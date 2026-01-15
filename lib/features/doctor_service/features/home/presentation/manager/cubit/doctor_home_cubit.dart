import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/service/signalR/models/booking_hub_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
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
  String initalSelectedYear = '';
  YearDataModel? yearDataModel;
  DoctorModel? user;

  int bookingStatus = 1;

  Set<int> bookingWithImagesIds = {};
  Set<int> showPatientImages = {};

  void toggleShowPatientImages(int bookingId) {
    if (showPatientImages.contains(bookingId)) {
      showPatientImages.remove(bookingId);
    } else {
      showPatientImages.add(bookingId);
    }
    emit(DoctorUpdate());
  }

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

        if (doctorChartModel != null && doctorChartModel!.years.isNotEmpty) {
          List<YearDataModel> sortedYears = doctorChartModel!.sortedYearsDesc;

          getChartDataByYear(year: sortedYears.first.year);
        } else {
          initalSelectedYear = DateTime.now().year.toString();
          emit(DoctorGetChartSuccess());
        }
      },
    );
  }

  Future<void> getDoctorBookings({required int status}) async {
    emit(DoctorGetBookingsLoading());
    doctorBookings.clear();
    bookingWithImagesIds.clear();
    showPatientImages.clear();
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
        for (var booking in doctorBookings) {
          if (booking.bookingImages.isNotEmpty) {
            bookingWithImagesIds.add(booking.bookingId);
          }
        }
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
    final currentDate = DateTime.now();
    if (currentChoosenDate!.isBefore(currentDate)) {
      emit(
        DoctorUpdateBookingFailure(
          errorMessage: "You can't update a past date!",
        ),
      );
    }
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
        getDoctorBookings(status: bookingStatus);

        emit(DoctorUpdateBookingSuccess());
      },
    );
  }

  void getChartDataByYear({required int year}) {
    initalSelectedYear = year.toString();

    for (var chart in doctorChartModel!.years) {
      if (chart.year == year) {
        yearDataModel = chart;
        emit(DoctorGetChartSuccess());
      }
    }
  }

  void whenServiceBooked({required BookingHubModel booking}) {
    getDoctorBookings(status: 1);
  }
  void whenServiceBookedOrCanceled({required BookingHubModel booking}) {
    getDoctorBookings(status: 1);
  }

  Future<void> getUserProfile() async {
    emit(GetProfileLoading());
    final String? userId = await getUserId();

    final response = await dashboardRepo.getDoctorProfile(userId: userId!);
    response.fold(
      (error) {
        emit(GetProfileFailure(errMsg: error));
      },
      (success) {
        user = success;
        emit(GetProfileSuccess());
      },
    );
  }
}
