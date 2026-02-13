import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/gym/features/dashboard/data/repo/gym_dashboard_repo.dart';

part 'gym_dashboard_state.dart';

class GymDashboardCubit extends Cubit<GymDashboardState> {
  final GymDashboardRepo gymDashboardRepo;
  GymDashboardCubit(this.gymDashboardRepo) : super(GymDashboardInitial());

  int bottomNavBarcurrentIndex = 0;
  void updateNavBarCurrentIndex(int index) {
    bottomNavBarcurrentIndex = index;
    emit(GymDashboardUpdateState());
  }
}
