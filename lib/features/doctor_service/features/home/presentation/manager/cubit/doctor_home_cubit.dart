import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/repo/doctor_dashboard_repo.dart';

part 'doctor_home_state.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  final DoctorDashboardRepo dashboardRepo;
  DoctorHomeCubit(this.dashboardRepo) : super(DoctorHomeInitial());
  DoctorChartModel? doctorChartModel;
  List<DoctorBookingModel> doctorBookings = [];
  DateTime? currentChoosenDate;
  TimeOfDay? currentChoosenFromTime;
  TimeOfDay? currentChoosenToTime;

  void updateTime() {
    emit(DoctorUpdate());
  }

  int navBarCurrentIndex = 0;
  updateNavBarCurrentIndex(int index) {
    navBarCurrentIndex = index;
    emit(DoctorUpdate());
  }

  Future<void> getDoctorChart() async {
    emit(DoctorGetChartLoading());
    final String? doctorId = await getUserId();
    final response = await dashboardRepo.getDoctorChart(doctorId: doctorId!);

    response.fold(
      (error) {
        emit(DoctorGetDataFailure(errorMessage: error));
      },
      (success) {
        doctorChartModel = success;
        emit(DoctorGetChartSuccess());
      },
    );
  }

  Future<void> getDoctorBookings({required int status}) async {
    emit(DoctorGetBookingsLoading());
    doctorBookings.clear();
    final String? doctorId = await getUserId();
    final response = await dashboardRepo.getDoctorBookings(
      doctorId: doctorId!,
      status: status,
    );

    response.fold(
      (error) {
        emit(DoctorGetDataFailure(errorMessage: error));
      },
      (success) {
        doctorBookings = success;
        emit(DoctorGetBookingsSuccess());
      },
    );
  }

  Future<void> cancelBooking({
    required int bookingId,
    required int index,
  }) async {
    emit(DoctorRemoveBookingLoading());
    final response = await dashboardRepo.removeBooking(
      bookingId: bookingId,
      status: 3,
    );
    response.fold(
      (error) {
        emit(DoctorRemoveBookingFailure(errorMessage: error));
      },
      (success) {
        doctorBookings.removeAt(index);
        emit(DoctorRemoveBookingSuccess());
      },
    );
  }

  Future<void> updateBooking({required DoctorBookingModel booking}) async {
    emit(DoctorUpdateBookingLoading());
    final response = await dashboardRepo.updateDoctorBooking(
      bookingId: booking.bookingId,
      bookingDate: DateFormat("yyyy-MM-dd").format(currentChoosenDate!),
      startTime: formatTimeOfDay(currentChoosenFromTime!),
      endTime: formatTimeOfDay(currentChoosenToTime!),
      dayofWeek: currentChoosenDate!.weekday % 7,
    );
    response.fold(
      (error) {
        emit(DoctorUpdateBookingFailure(errorMessage: error));
      },
      (success) {
        getDoctorBookings(status: 1);

        emit(DoctorUpdateBookingSuccess());
      },
    );
  }
}
