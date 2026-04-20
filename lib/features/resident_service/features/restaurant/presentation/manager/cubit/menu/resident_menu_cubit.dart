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
        emit(ResidentGetMenuCategoryItemsLoadedState(items));
      },
    );
  }

  void filterItemsByCategory({required int categoryId}) {
    if (categoryId == 0) {
      emit(ResidentGetMenuCategoryItemsLoadedState(allCategoriesItems));
      return;
    }
    List<RestauarantMenuItemModel> filteredItems = allCategoriesItems
        .where((element) => element.categoryId == categoryId)
        .toList();
    emit(ResidentGetMenuCategoryItemsLoadedState(filteredItems));
  }
}
