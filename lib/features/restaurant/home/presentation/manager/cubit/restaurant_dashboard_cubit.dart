import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';
import 'package:wasla/features/restaurant/home/data/models/resturant_chart_model.dart';
import 'package:wasla/features/restaurant/home/data/repo/restaurant_dashboard_repo.dart';

part 'restaurant_dashboard_state.dart';

class RestaurantDashboardCubit extends Cubit<RestaurantDashboardState> {
  RestaurantDashboardCubit(this.repo) : super(RestaurantDashboardInitial());
  final RestaurantDashboardRepo repo;
  int bottomNabBarIndex = 0;

  ResturantChartModel? restaurantChart;
  String initalSelectedYear = '';
  YearDataModel? yearDataModel;

  void updateBottomNavBarIndex(int index) {
    bottomNabBarIndex = index;
    emit(RestaurantDashboardUpdateBottomNavBarIndex());
  }

  void onRetry() {
    emit(RestaurantDashboardOnRetryState());
  }

  Future<void> getRestaurantData() async {
    final String? restaurantId = await getUserId();

    final result = await GlobalRepo.getRestaurantProfile(
      resturantId: restaurantId!,
    );

    result.fold(
      (error) {
        if (error is NoInternetFailure) {
          emit(RestaurantDashboardNetworkState());
        } else {
          emit(RestaurantDashboardFailureState());
        }
      },
      (data) {
        emit(RestaurantDashboardGetDataSuccessState(restaurant: data));
      },
    );
  }

  Future<void> getRestaurantStatistics() async {
    final String? restaurantId = await getUserId();
    emit(RestaurantDashboardGetChartLoading());
    final res = await repo.getRestaurantChart(restaurantId: restaurantId!);
    res.fold(
      (error) {
        if (error is NoInternetFailure) {
          emit(RestaurantDashboardNetworkState());
        } else {
          emit(RestaurantDashboardFailureState());
        }
      },
      (success) {
        restaurantChart = success;
        if (restaurantChart != null && restaurantChart!.years.isNotEmpty) {
          List<YearDataModel> sortedYears = restaurantChart!.sortedYearsDesc;
          getChartDataByYear(year: sortedYears.first.year, fromDropDown: false);
        } else {
          initalSelectedYear = DateTime.now().year.toString();
          emit(RestaurantDashboardGetChartSuccess());
        }
      },
    );
  }

  void getChartDataByYear({required int year, required bool fromDropDown}) {
    initalSelectedYear = year.toString();
    for (var chart in restaurantChart!.years) {
      if (chart.year == year) {
        yearDataModel = chart;
        if (fromDropDown) {
          emit(RestaurantDashboardGetChartFromDropDown());
        } else {
          emit(RestaurantDashboardGetChartSuccess());
        }
      }
    }
  }
}
