import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/data/models/restaurant_catergories_model.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';

class RestaurantCompleteInfoCategory extends StatefulWidget {
  const RestaurantCompleteInfoCategory({super.key});

  @override
  State<RestaurantCompleteInfoCategory> createState() =>
      _RestaurantCompleteInfoCategoryState();
}

class _RestaurantCompleteInfoCategoryState
    extends State<RestaurantCompleteInfoCategory> {
  @override
  void initState() {
    getRestaurantCatergories();
    super.initState();
  }

  List<RestaurantCatergoriesModel> catergories = [];
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is GetRestaurantCatergoriesSuccessState ||
          current is GetRestaurantCatergoriesErrorState,
      builder: (context, state) {
        if (state is GetRestaurantCatergoriesSuccessState) {
          catergories = state.catergories;
        }
        if (state is GetRestaurantCatergoriesErrorState) {
          showToast(state.error);
        }
        return CustomDropDownMenu(
          hint: "selectCategory".tr(context),

          items: catergories
              .map(
                (category) => DropDownItem(
                  label: category.name,
                  value: category.id.toString(),
                ),
              )
              .toList(),
          onSelecte: (category) {
            cubit.updateRestaurantCategory(category: int.parse(category!));
          },
        );
      },
    );
  }

  void getRestaurantCatergories() {
    final cubit = context.read<AuthCubit>();
    cubit.getRestaurantCategories();
  }
}
