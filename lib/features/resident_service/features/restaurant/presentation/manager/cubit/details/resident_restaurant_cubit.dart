import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/repo/global_repo.dart';
import 'package:wasla/features/auth/data/models/restaurant_catergories_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/details/resident_restaurant_repo.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

part 'resident_restaurant_state.dart';

class ResidentRestaurantCubit extends Cubit<ResidentRestaurantState> {
  ResidentRestaurantCubit(this.repo) : super(ResidentRestaurantInitial());
  final ResidentRestaurantRepo repo;

  final int pageSize = 10;
  int pageNumber = 1;
  bool endOfPagination = false;
  int categoryId = 0;
  int numberOfPersons = 1;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimeSlot = TimeOfDay.now();

  void onRetry() {
    emit(ResidentRestaurantOnRetryState());
  }

  void selectCategory({required categoryId}) {
    if (categoryId != this.categoryId) {
      this.categoryId = categoryId;
      pageNumber = 1;
      endOfPagination = false;
      emit(ResidentRestaurantSelectCategoryState());
      getRestaurantsByCategory(fromPagination: false);

      ///call getRestaurantsByCategory
    }
  }

  void updateSelectedDate({required DateTime date}) {
    selectedDate = date;
  }

  void updateSelectedTimeSlot({required TimeOfDay time}) {
    selectedTimeSlot = time;
    emit(ResidentRestaurantSelectTimeSlot());
  }

  Future<void> getRestaurantsByCategory({required bool fromPagination}) async {
    if (endOfPagination ||
        state is GetRestaurantsByCategorieFromPaginationLoadingState) {
      return;
    }
    if (fromPagination) {
      emit(GetRestaurantsByCategorieFromPaginationLoadingState());
    } else {
      emit(GetRestaurantsByCategorieLoadingState());
    }

    final result = await repo.getAllRestaurantsByCategory(
      pageNumber: pageNumber,
      pageSize: pageSize,
      categoryId: categoryId,
    );

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(ResidentRestaurantNetworkState());
        } else {
          emit(ResidentRestaurantFailureState());
        }
      },
      (success) {
        if (success.isEmpty) {
          endOfPagination = true;
        } else {
          pageNumber++;
        }

        emit(GetRestaurantsByCategoryLoadedState(restaurants: success));
      },
    );
  }

  Future<void> getRestaurantCategories() async {
    emit(GetRestaurantCategoriesLoadingState());
    final result = await repo.getRestaurantCategories();
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(ResidentRestaurantNetworkState());
        } else {
          emit(ResidentRestaurantFailureState());
        }
      },
      (categories) =>
          emit(GetRestaurantCategoriesLoadedState(categories: categories)),
    );
  }

  Future<void> getRestaurantDetails({required String restaurantId}) async {
    emit(ResidentRestaurantDashboardGetDataLoadingState());
    final result = await GlobalRepo.getRestaurantProfile(
      resturantId: restaurantId,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(ResidentRestaurantNetworkState());
        } else {
          emit(ResidentRestaurantFailureState());
        }
      },
      (restaurant) => emit(
        ResidentRestaurantDashboardGetDataSuccessState(restaurant: restaurant),
      ),
    );
  }

  Future<void> reservationWithRestaurant({required String restaurantId}) async {
    emit(ResidentRestaurantReservationLoadingState());
    final String? userId = await getUserId();
    final result = await repo.reservationWithRestaurant(
      restaurantId: restaurantId,
      numberOfPersons: numberOfPersons,
      userId: userId!,
      date: DateFormat('yyyy-MM-dd').format(selectedDate),
      time: convertTimeToGoodFormat(selectedTimeSlot),
    );

    result.fold((failure) {
      emit(ResidentRestaurantReservationFailureState(message: failure));
    }, (success) => emit(ResidentRestaurantReservationSuccessState()));
  }
}
