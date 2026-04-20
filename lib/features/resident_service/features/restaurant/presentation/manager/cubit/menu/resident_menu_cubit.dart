import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restauarant_menu_item_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_menu_category_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/menu/resident_menu_repo.dart';

part 'resident_menu_state.dart';

class ResidentMenuCubit extends Cubit<ResidentMenuState> {
  ResidentMenuCubit(this.menu) : super(ResidentMenuInitial());

  final ResidentMenuRepo menu;

  List<RestauarantMenuItemModel> allCategoriesItems = [];

  int currentCategoryId = 0;

  void onRetry() {
    emit(ResidentMenuOnRetryState());
  }

  void selectMenuCategory({required int categoryId}) {
    if (categoryId != currentCategoryId) {
      currentCategoryId = categoryId;
      emit(ResidentMenuSelectCategory());
      filterItemsByCategory(categoryId: categoryId);
    }
  }

  Future<void> getMenuCategories({required String restaurantId}) async {
    emit(ResidentGetMenuCateroriesLoadingState());
    final result = await menu.getMenuCategories(restaurantId: restaurantId);
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(ResidentMenuNetworkState());
      } else {
        emit(ResidentMenuFailureState());
      }
    }, (categories) => emit(ResidentGetMenuCateroriesLoadedState(categories)));
  }

  Future<void> getMenuItems({required String restaurantId}) async {
    emit(ResidentGetMenuCategoryItemsLoadingState());
    final result = await menu.getMenuItems(restaurantId: restaurantId);
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(ResidentMenuNetworkState());
        } else {
          emit(ResidentMenuFailureState());
        }
      },
      (items) {
        log(items.length.toString());
        allCategoriesItems = items;

        filterItemsByCategory(categoryId: 0);
      },
    );
  }

  void filterItemsByCategory({required int categoryId}) {
    if (categoryId == 0) {
      List<MenuItem> allItems = [];
      for (var element in allCategoriesItems) {
        allItems.addAll(element.items);
      }

      emit(ResidentGetMenuCategoryItemsLoadedState(allItems));
      return;
    }

    List<MenuItem> filteredItems = [];
    for (var element in allCategoriesItems) {
      if (element.categoryId == categoryId) {
        filteredItems.addAll(element.items);
      }
    }
    emit(ResidentGetMenuCategoryItemsLoadedState(filteredItems));
  }
}
