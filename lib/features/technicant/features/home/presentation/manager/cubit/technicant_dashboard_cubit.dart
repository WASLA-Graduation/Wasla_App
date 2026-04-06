import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/technicant/features/home/data/repo/technicant_dashboard_repo.dart';

part 'technicant_dashboard_state.dart';

class TechnicantDashboardCubit extends Cubit<TechnicantDashboardState> {
  TechnicantDashboardCubit(this.repo) : super(TechnicantDashboardInitial());

  final TechnicantDashboardRepo repo;

  int bottomNabBarIndex = 0;

  void changeBottomNavBarIndex(int index) {
    bottomNabBarIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }
}
