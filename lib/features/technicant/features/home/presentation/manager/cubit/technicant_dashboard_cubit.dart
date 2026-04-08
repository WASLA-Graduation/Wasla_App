import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_chart_model.dart';
import 'package:wasla/features/driver/features/home/data/models/technician_statistics_model.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';
import 'package:wasla/features/technicant/features/home/data/repo/technicant_dashboard_repo.dart';

part 'technicant_dashboard_state.dart';

class TechnicantDashboardCubit extends Cubit<TechnicantDashboardState> {
  TechnicantDashboardCubit(this.repo) : super(TechnicantDashboardInitial());

  final TechnicantDashboardRepo repo;

  int bottomNabBarIndex = 0;

  TechnicianStatisticsModel? technicianChart;
  String initalSelectedYear = '';
  YearDataModel? yearDataModel;

  void whenRetry() {
    emit(TechnicianOnRetryState());
  }

  void changeBottomNavBarIndex(int index) {
    bottomNabBarIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  Future<void> getTechnicianProfile() async {
    final String? userId = await getUserId();
    final result = await GlobalRepo.getTechnicianProfile(technicianId: userId!);
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(TechnicianNetworkState());
      } else {
        emit(TechnicianErrorState());
      }
    }, (profile) => emit(TechnicianGetProfile(technician: profile)));
  }

  Future<void> getTechnicianStatistics() async {
    final String? technicainId = await getUserId();
    emit(TechnicainGetDashboardDataLoading());
    final res = await repo.getTechnicianChart(id: technicainId!);
    res.fold(
      (error) {
        if (error is NoInternetFailure) {
          emit(TechnicianNetworkState());
        } else {
          emit(TechnicianErrorState());
        }
      },
      (success) {
        technicianChart = success;

        if (technicianChart != null && technicianChart!.years.isNotEmpty) {
          List<YearDataModel> sortedYears = technicianChart!.sortedYearsDesc;
          getChartDataByYear(year: sortedYears.first.year, fromDropDown: false);
        } else {
          initalSelectedYear = DateTime.now().year.toString();
          emit(TechnicainGetDashboardDataSuccess());
        }
      },
    );
  }

  void getChartDataByYear({required int year, required bool fromDropDown}) {
    initalSelectedYear = year.toString();
    for (var chart in technicianChart!.years) {
      if (chart.year == year) {
        yearDataModel = chart;
        if (fromDropDown) {
          emit(TechnicainGetDashboardDataFromDropDown());
        } else {
          emit(TechnicainGetDashboardDataSuccess());
        }
      }
    }
  }
}
