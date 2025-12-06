import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/data/repo/doctor_service_mangement_repo.dart';
part 'doctor_service_mangement_state.dart';

class DoctorServiceMangementCubit extends Cubit<DoctorServiceMangementState> {
  DoctorServiceMangementCubit(this.doctorRepo)
    : super(DoctorServiceMangementInitial());
  final DoctorServiceMangementRepo doctorRepo;
  Set<int> daysIndices = {};
  List<DoctorServiceModel> sevices = [];
  bool? daysSelected;
  final GlobalKey<FormState> addServiceFormKey = GlobalKey<FormState>();
  String serviceNameAr = '',
      serviceNameEn = '',
      serviceDescAr = '',
      serviceDescEn = '';

  List<Map<String, TimeOfDay>> timeSlotsList = [];
  double price = 0;
  TimeOfDay inintailTime = TimeOfDay(hour: 8, minute: 0);

  void addTimeSlot() {
    if (timeSlotsList.isEmpty) {
      final DateTime date = _addHourToLastTime(inintailTime);

      timeSlotsList.add({
        'from': inintailTime,
        'to': TimeOfDay(hour: date.hour, minute: date.minute),
      });
    } else {
      final Map<String, TimeOfDay> lastTimeSlot = timeSlotsList.last;
      DateTime date = _addHourToLastTime(lastTimeSlot['to']!);
      timeSlotsList.add({
        'from': lastTimeSlot['to']!,
        'to': TimeOfDay(hour: date.hour, minute: date.minute),
      });
    }

    emit(DoctorServiceMangementUpdate());
  }

  void upadeTimeSlot({
    required int index,
    required TimeOfDay time,
    required bool isFrom,
  }) {
    if (isFrom) {
      timeSlotsList[index]['from'] = time;
    } else {
      timeSlotsList[index]['to'] = time;
    }
    emit(DoctorServiceMangementUpdate());
  }

  DateTime _addHourToLastTime(TimeOfDay lastTimeSlot) {
    final DateTime now = DateTime.now();
    DateTime date = DateTime(
      now.year,
      now.day,
      now.day,
      lastTimeSlot.hour,
      lastTimeSlot.minute,
    );
    date = date.add(Duration(hours: 1));
    return date;
  }

  void removeTimeSlot({required int index}) {
    timeSlotsList.removeAt(index);
    emit(DoctorServiceMangementUpdate());
  }

  void addOrRemoveDaysIndex(int index) {
    if (daysIndices.contains(index)) {
      daysIndices.remove(index);
    } else {
      daysIndices.add(index);
    }
    emit(DoctorServiceMangementUpdate());
  }

  void checkDaysSelected() {
    if (daysIndices.isEmpty) {
      daysSelected = false;
    } else {
      daysSelected = true;
    }
    emit(DoctorServiceMangementUpdate());
  }

  Future<void> getDoctorServices() async {
    sevices.clear();
    emit(DoctorServiceMangementGetServiceLoading());
    final String? userId = await getUserId();
    final response = await doctorRepo.getDoctorService(userId: userId!);
    response.fold(
      (error) {
        emit(DoctorServiceMangementGetServiceFailure(errorMessage: error));
      },
      (success) {
        sevices = success;
        resetState();
        emit(DoctorServiceMangementGetServiceSuccess());
      },
    );
  }

  Future<void> deletDoctorService({required int serviceId}) async {
    emit(DoctorServiceMangementDelateServiceLoading());
    final response = await doctorRepo.deleteDoctorService(serviceId: serviceId);

    response.fold(
      (error) {
        emit(DoctorServiceMangementDelateServiceFailure(errorMessage: error));
      },
      (success) async {
        await getDoctorServices();
        emit(DoctorServiceMangementDelateServiceSuccess());
      },
    );
  }

  Future<void> addDoctorService() async {
    if (timeSlotsList.isEmpty) {
      emit(
        DoctorServiceMangementAddOrUpdateServiceFailure(
          errorMessage: 'You Must Choose At Least One Time Slot',
        ),
      );
      return;
    }
    emit(DoctorServiceMangementAddOrUpdateServiceLoading());
    final String? doctorId = await getUserId();
    final response = await doctorRepo.addDoctorService(
      doctorId: doctorId!,
      price: price,
      serviceName: {
        ApiKeys.arabic: serviceNameAr,
        ApiKeys.english: serviceNameEn,
      },
      description: {
        ApiKeys.arabic: serviceDescAr,
        ApiKeys.english: serviceDescEn,
      },

      serviceDays: daysIndices.map((e) => {ApiKeys.dayOfWeek: e}).toList(),

      timeSlots: timeSlotsList
          .map(
            (e) => {
              ApiKeys.start: formatTimeOfDay(e["from"]!),
              ApiKeys.end: formatTimeOfDay(e["from"]!),
            },
          )
          .toList(),
    );

    response.fold(
      (error) {
        emit(
          DoctorServiceMangementAddOrUpdateServiceFailure(errorMessage: error),
        );
      },
      (success) async {
        await getDoctorServices();
        emit(DoctorServiceMangementAddOrUpdateServiceSuccess());
      },
    );
  }

  Future<void> updateDoctorService({
    required DoctorServiceModel service,
  }) async {
    if (timeSlotsList.isEmpty) {
      emit(
        DoctorServiceMangementAddOrUpdateServiceFailure(
          errorMessage: 'You Must Choose At Least One Time Slot',
        ),
      );
      return;
    }

    emit(DoctorServiceMangementAddOrUpdateServiceLoading());
    final response = await doctorRepo.updateDoctorService(
      serviceId: service.id,
      price: price == 0 ? service.price : price,
      serviceName: {
        ApiKeys.arabic: serviceNameAr.isEmpty
            ? service.serviceNameArabic
            : serviceNameAr,
        ApiKeys.english: serviceNameEn.isEmpty
            ? service.serviceNameEnglish
            : serviceNameEn,
      },
      description: {
        ApiKeys.arabic: serviceDescAr.isEmpty
            ? service.descriptionArabic
            : serviceDescAr,
        ApiKeys.english: serviceDescEn.isEmpty
            ? service.descriptionEnglish
            : serviceDescEn,
      },

      serviceDays: daysIndices.map((e) => {ApiKeys.dayOfWeek: e}).toList(),

      timeSlots: timeSlotsList
          .map(
            (e) => {
              ApiKeys.start: formatTimeOfDay(e["from"]!),
              ApiKeys.end: formatTimeOfDay(e["from"]!),
            },
          )
          .toList(),
    );

    response.fold(
      (error) {
        emit(
          DoctorServiceMangementAddOrUpdateServiceFailure(errorMessage: error),
        );
      },
      (success) async {
        await getDoctorServices();
        emit(DoctorServiceMangementAddOrUpdateServiceSuccess());
      },
    );
  }

  void resetState() {
    daysIndices.clear();
    serviceNameAr = '';
    serviceNameEn = '';
    serviceDescAr = '';
    serviceDescEn = '';
    price = 0;
    inintailTime = TimeOfDay(hour: 8, minute: 0);
    timeSlotsList.clear();
  }
}
