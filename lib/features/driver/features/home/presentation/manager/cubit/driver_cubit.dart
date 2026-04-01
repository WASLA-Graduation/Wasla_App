import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_chart_data_model.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/driver/features/home/data/repo/driver_repo.dart';

part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit(this.driverRepo) : super(DriverInitial());

  final DriverRepo driverRepo;

  int bottomNabBarIndex = 0;
  DriverProfileModel? user;
  DriverStatisticsModel? driverChart;
  String initalSelectedYear = '';
  YearDataModel? yearDataModel;

  void updateBottomNavBarIndex({required int index}) {
    if (index != bottomNabBarIndex) {
      bottomNabBarIndex = index;
      emit(DriverUpdateBottomNabBarIndex());
    }
  }

  Future<void> getDriverProfile() async {
    emit(DriverGetProfileLoading());
    final String? driverId = await getUserId();
    final result = await driverRepo.getDriverProfile(id: driverId!);
    result.fold((error) => emit(DriverGetProfileFailure(message: error)), (
      success,
    ) {
      user = success;
      emit(DriverGetProfileSuccess());
    });
  }

  Future<void> getDriverStatistics() async {
    final String? driverId = await getUserId();
    emit(DriverGetDashboardDataLoading());
    final res = await driverRepo.getDriverChart(driverId: driverId!);
    res.fold((error) => emit(DriverDashboardDataFailure(message: error)), (
      success,
    ) {
      driverChart = success;

      if (driverChart != null && driverChart!.years.isNotEmpty) {
        List<YearDataModel> sortedYears = driverChart!.sortedYearsDesc;
        getChartDataByYear(year: sortedYears.first.year, fromDropDown: false);
      } else {
        initalSelectedYear = DateTime.now().year.toString();
        emit(DriverGetDashboardDataSuccess());
      }
    });
  }

  void getChartDataByYear({required int year, required bool fromDropDown}) {
    initalSelectedYear = year.toString();

    for (var chart in driverChart!.years) {
      if (chart.year == year) {
        yearDataModel = chart;
        if (fromDropDown) {
          emit(DriverGetDashboardDataFromDropDown());
        } else {
          emit(DriverGetDashboardDataSuccess());
        }
      }
    }
  }
}
