import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';
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
}
