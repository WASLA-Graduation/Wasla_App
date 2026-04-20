import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/auth/data/models/restaurant_catergories_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/resident_restaurant_repo.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

part 'resident_restaurant_state.dart';

class ResidentRestaurantCubit extends Cubit<ResidentRestaurantState> {
  ResidentRestaurantCubit(this.repo) : super(ResidentRestaurantInitial());
  final ResidentRestaurantRepo repo;

  final int pageSize = 10;
  int pageNumber = 1;
  bool endOfPagination = false;
  int categoryId = 0;

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
}
