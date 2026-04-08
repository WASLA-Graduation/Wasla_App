import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';
import 'package:wasla/features/technicant/features/home/data/repo/technicant_dashboard_repo.dart';

part 'technicant_dashboard_state.dart';

class TechnicantDashboardCubit extends Cubit<TechnicantDashboardState> {
  TechnicantDashboardCubit(this.repo) : super(TechnicantDashboardInitial());

  final TechnicantDashboardRepo repo;

  int bottomNabBarIndex = 0;

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
}
