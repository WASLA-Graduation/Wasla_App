import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wasla/core/functions/get_time_between_now_and_any_time.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/models/doctor_specializationa_model.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/data/repo/doctor_repo.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepo doctorRepo;
  DoctorCubit(this.doctorRepo) : super(DoctorInitial());
  List<DoctorSpecializationaModel> specialityList = [];

  int specializationIndex = 0;
  List<bool> favouriteDocs = List.filled(10, false);

  int ratingIndex = 0;
  List<DoctorDataModel> doctors = [];
  List<DoctorServiceModel> services = [];
  int dayCurrentIndex = 0;
  int timeCurrentIndex = -1;

  List<String> dayListTimeSlots = [];

  String doctorBookingTypeGroupValue = "Examination";
  int gruoupValueIndex = 1;
  int? serviceSelectedDayAndTimeId;
  Set<int> timeSlotIds = {};
  String? doctorId;
  int? dayOfWeek;

  void updateDoctorGroupValue(String value) {
    doctorBookingTypeGroupValue = value;
    emit(DoctorUpdateState());
  }

  void changeDayCurrentIndexAndUpadatTimeSlote(
    int index, {
    required ServiceDayModel serviceDay,
  }) {
    dayCurrentIndex = index;
    dayOfWeek = null;
    dayOfWeek = serviceDay.dayOfWeek;
    addDayTimeSlotToList(serviceDay: serviceDay);
    emit(DoctorUpdateState());
  }

  void addDayTimeSlotToList({required ServiceDayModel serviceDay}) {
    dayListTimeSlots = [];
    timeSlotIds = {};
    serviceSelectedDayAndTimeId = null;
    for (var time in serviceDay.timeSlots) {
      if (!time.isBooking) {
        dayListTimeSlots.add(time.start);
        timeSlotIds.add(time.id);
      }
    }
  }

  void changeTimeCurrentIndex(
    int index, {
    required ServiceDayModel serviceDay,
  }) {
    timeCurrentIndex = index;
    serviceSelectedDayAndTimeId = serviceDay.timeSlots[index].id;

    emit(DoctorUpdateState());
  }

  void changeSpecializationIndex(int index) {
    specializationIndex = index;
    emit(DoctorUpdateState());
  }

  void changeRatingIndex(int index) {
    ratingIndex = index;
    emit(DoctorUpdateState());
  }

  void toggleFavouriteIcon({required index}) {
    favouriteDocs[index] = !favouriteDocs[index];
    emit(DoctorUpdateState());
  }

  Future<void> getDoctorSpecialization() async {
    emit(DoctorGetSpecialityListLoading());
    specialityList.clear();
    final response = await doctorRepo.getSpecialization();
    response.fold(
      (error) {
        emit(DoctorGetSpecialityListFailure(errMsg: error));
      },
      (success) {
        specialityList = success;
        specialityList.insert(
          0,
          DoctorSpecializationaModel(id: 0, specialization: "all"),
        );
        emit(DoctorGetSpecialityListSuccess());
      },
    );
  }

  Future<void> getDoctorsBySpecialization({
    required int specializationId,
  }) async {
    emit(DoctorGetBySpecialityListLoading());
    doctors.clear();
    final response = await doctorRepo.getDoctorsBySpecialization(
      specializationId: specializationId,
    );
    response.fold(
      (error) {
        emit(DoctorGetBySpecialityListFailure(errMsg: error));
      },
      (success) {
        doctors = success;

        emit(DoctorGetBySpecialityListSuccess());
      },
    );
  }

  Future<void> getDoctorServices({required String doctorId}) async {
    services.clear();
    emit(DoctorGetServicesListLoading());
    final response = await doctorRepo.getDoctorService(userId: doctorId);
    response.fold(
      (error) {
        emit(DoctorGetServicesListFailure(errMsg: error));
      },
      (success) {
        services = success;
        emit(DoctorGetServicesListSuccess());
      },
    );
  }

  Future<void> bookService({
    required DoctorServiceModel doctorServiceModel,
  }) async {
    if (serviceSelectedDayAndTimeId == null) {
      emit(DoctorBookServiceFailure(errMsg: "Please select Time Slot"));
    } else {
      emit(DoctorBookServiceLoading());
      final String? userId = await getUserId();
      final response = await doctorRepo.bookService(
        userId: userId!,
        doctorId: doctorId!,
        serviceDayId: serviceSelectedDayAndTimeId!,
        price: doctorServiceModel.price,
        bookingType: gruoupValueIndex,
        serviceProviderType: 1,
        images: null,
        bookingDate: DateFormat(
          "yyyy-MM-dd",
        ).format(getNextDayFromZeroIndex(dayOfWeek!)),
      );
      response.fold(
        (error) {
          emit(DoctorBookServiceFailure(errMsg: error));
        },
        (success) {
          emit(DoctorBookServiceSuccess());
        },
      );
    }
  }
}
