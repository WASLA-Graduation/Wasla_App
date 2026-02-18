import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_booking_model.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_statistics_model.dart';
import 'package:wasla/features/gym/features/dashboard/data/repo/gym_dashboard_repo.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';

part 'gym_dashboard_state.dart';

class GymDashboardCubit extends Cubit<GymDashboardState> {
  final GymDashboardRepo gymDashboardRepo;
  GymDashboardCubit(this.gymDashboardRepo) : super(GymDashboardInitial());

  int bottomNavBarcurrentIndex = 0;
  GymModel? gym;

  GymStatisticsModel? gymStatisticsModel;
  String initalSelectedYear = '';
  YearDataModel? yearDataModel;

  List<GymBookingModel> gymBookings = [];
  BookingStatus gymBookingsStatus = BookingStatus.active;

  void updateNavBarCurrentIndex(int index) {
    bottomNavBarcurrentIndex = index;
    emit(GymDashboardUpdateState());
  }

  void whenBookingStatusChanged({required BookingStatus status}) async {
    gymBookingsStatus = status;
    getGymBookingsByStatus();
  }

  Future<void> getGymProfile() async {
    final String? gymId = await getUserId();
    emit(GymDashboardProfileGetProfileLoading());
    final res = await gymDashboardRepo.geGymProfile(gymId: gymId!);
    res.fold(
      (error) => emit(GymDashboardProfileGetProfileFailure(errMsg: error)),
      (success) {
        gym = success;
        emit(GymDashboardProfileGetProfileSuccess());
      },
    );
  }

  Future<void> getGymStatistics() async {
    final String? gymId = await getUserId();
    emit(GymDashboardProfileGetChartLoading());
    final res = await gymDashboardRepo.getGymCharts(gymId: gymId!);
    res.fold(
      (error) => emit(GymDashboardProfileGetChartFailure(errMsg: error)),
      (success) {
        gymStatisticsModel = success;

        if (gymStatisticsModel != null &&
            gymStatisticsModel!.years.isNotEmpty) {
          List<YearDataModel> sortedYears = gymStatisticsModel!.sortedYearsDesc;

          getChartDataByYear(year: sortedYears.first.year);
        } else {
          initalSelectedYear = DateTime.now().year.toString();
          emit(GymDashboardProfileGetChartSuccess());
        }
      },
    );
  }

  void getChartDataByYear({required int year}) {
    initalSelectedYear = year.toString();

    for (var chart in gymStatisticsModel!.years) {
      if (chart.year == year) {
        yearDataModel = chart;
        emit(GymDashboardProfileGetChartSuccess());
      }
    }
  }

  Future<void> getGymBookingsByStatus() async {
    final String? gymId = await getUserId();
    gymBookings.clear();
    emit(GymDashboardProfileGetBookingsListLoading());
    final res = await gymDashboardRepo.getGymBookings(
      status: gymBookingsStatus,
      gymId: gymId!,
    );
    res.fold(
      (error) => emit(GymDashboardProfileGetBookingsListFailure(errMsg: error)),
      (success) {
        gymBookings = success;
        emit(GymDashboardProfileGetBookingsListSuccess());
      },
    );
  }

  Future<void> gymCancelBooking({
    required GymBookingModel bookingModel,
    required int bookingIndex,
  }) async {
    emit(GymDashboardCancelBookingLoading());
    final GymBookingModel booking = bookingModel;

    gymBookings.removeAt(bookingIndex);

    final res = await gymDashboardRepo.gymCancelBooking(
      bookingId: bookingModel.bookingId,
    );
    res.fold(
      (error) {
        gymBookings.insert(bookingIndex, booking);
        emit(GymDashboardCancelBookingFailure(errMsg: error));
      },
      (success) {
        getGymBookingsByStatus();
        emit(GymDashboardCancelBookingSuccess());
      },
    );
  }

  void reset() {
    gymBookingsStatus = BookingStatus.active;
  }
}
