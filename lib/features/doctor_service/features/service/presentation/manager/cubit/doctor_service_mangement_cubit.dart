import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wasla/core/database/api/api_keys.dart';
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
  int price = 0;
  TimeOfDay timeFrom = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay timeTo = TimeOfDay(hour: 10, minute: 0);
  DateTime? selectedDate;

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

  void upadteTimeFrom({required TimeOfDay time}) {
    timeFrom = time;
    emit(DoctorServiceMangementUpdate());
  }

  void upadteTimeTo({required TimeOfDay time}) {
    timeTo = time;
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
        _resetState();
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
    int checkTime = timeFrom.hour - timeTo.hour;
    checkTime = checkTime.abs();
    if (checkTime > 1) {
      emit(
        DoctorServiceMangementAddOrUpdateServiceFailure(
          errorMessage: "Time must not exceed one hour",
        ),
      );
      return;
    }
    if (selectedDate == null) {
      emit(
        DoctorServiceMangementAddOrUpdateServiceFailure(
          errorMessage: "You Must Select Date",
        ),
      );
      return;
    }

    emit(DoctorServiceMangementAddOrUpdateServiceLoading());
    final String? doctorId = await getUserId();
    final response = await doctorRepo.addDoctorService(
      doctorId: doctorId!,
      price: price.toDouble(),
      serviceName: {
        ApiKeys.arabic: serviceNameAr,
        ApiKeys.english: serviceNameEn,
      },
      description: {
        ApiKeys.arabic: serviceDescAr,
        ApiKeys.english: serviceDescEn,
      },

      serviceDays: daysIndices
          .map((e) => ServiceDay(dayOfWeek: e, id: e))
          .toList(),

      serviceDates: [
        ServiceDate(
          date: DateFormat('yyyy-MM-dd').format(selectedDate!),
          id: 0,
        ),
      ],
      timeSlots: [
        TimeSlot(
          start: _formatTimeOfDay(timeFrom),
          end: _formatTimeOfDay(timeTo),
          id: 0,
        ),
      ],
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
    int checkTime = timeFrom.hour - timeTo.hour;
    checkTime = checkTime.abs();
    if (checkTime > 1) {
      emit(
        DoctorServiceMangementAddOrUpdateServiceFailure(
          errorMessage: "Time must not exceed one hour",
        ),
      );
      return;
    }

    emit(DoctorServiceMangementAddOrUpdateServiceLoading());
    final response = await doctorRepo.updateDoctorService(
      serviceId: service.id,
      price: price.toDouble() == 0 ? service.price : price.toDouble(),
      serviceName: {
        ApiKeys.arabic: serviceNameAr.isEmpty
            ? service.serviceNameAr
            : serviceNameAr,
        ApiKeys.english: serviceNameEn.isEmpty
            ? service.serviceNameEn
            : serviceNameEn,
      },
      description: {
        ApiKeys.arabic: serviceDescAr.isEmpty
            ? service.descriptionAr
            : serviceDescAr,
        ApiKeys.english: serviceDescEn.isEmpty
            ? service.descriptionEn
            : serviceDescEn,
      },

      serviceDays: daysIndices.isEmpty
          ? service.serviceDays
          : daysIndices.map((e) => ServiceDay(dayOfWeek: e, id: e)).toList(),

      serviceDates: selectedDate == null
          ? service.serviceDates
          : [
              ServiceDate(
                date: DateFormat('yyyy-MM-dd').format(selectedDate!),
                id: 0,
              ),
            ],
      timeSlots: [
        TimeSlot(
          start: _formatTimeOfDay(timeFrom),
          end: _formatTimeOfDay(timeTo),
          id: 0,
        ),
      ],
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

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute:00";
  }

  void _resetState() {
    daysIndices.clear();
    selectedDate = null;
    serviceNameAr = '';
    serviceNameEn = '';
    serviceDescAr = '';
    serviceDescEn = '';
    price = 0;
  }
}
