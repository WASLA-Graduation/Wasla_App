import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/restaurant/home/data/repo/restaurant_dashboard_repo.dart';

part 'restaurant_dashboard_state.dart';

class RestaurantDashboardCubit extends Cubit<RestaurantDashboardState> {
  RestaurantDashboardCubit(this.repo) : super(RestaurantDashboardInitial());
  final RestaurantDashboardRepo repo;
  int bottomNabBarIndex = 0;

  void updateBottomNavBarIndex(int index) {
    bottomNabBarIndex = index;
    emit(RestaurantDashboardUpdateBottomNavBarIndex());
  }

  void onRetry() {
    emit(RestaurantDashboardOnRetryState());
  }
}
