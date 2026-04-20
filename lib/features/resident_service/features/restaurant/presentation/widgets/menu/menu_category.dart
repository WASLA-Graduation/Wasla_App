import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/helpers/loadings/speciality_loading_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_speciality_item.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_menu_category_model.dart';
import 'package:wasla/features/restaurant/menu/presentation/manager/cubit/resident_menu_cubit.dart';

class ResidnetRestaurantMenuCategory extends StatefulWidget {
  const ResidnetRestaurantMenuCategory({super.key});

  @override
  State<ResidnetRestaurantMenuCategory> createState() =>
      _ResidnetRestaurantMenuCategoryState();
}

class _ResidnetRestaurantMenuCategoryState
    extends State<ResidnetRestaurantMenuCategory> {
  List<RestaurantMenuCategoryModel> categories = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentMenuCubit, ResidentMenuState>(
      buildWhen: (previous, current) =>
          current is ResidentGetMenuCateroriesLoadingState ||
          current is ResidentGetMenuCateroriesLoadedState ||
          current is ResidentMenuSelectCategory,
      builder: (context, state) {
        if (state is ResidentGetMenuCateroriesLoadingState ||
            state is ResidentMenuInitial) {
          return const SpecialityLoadingList();
        }
        if (state is ResidentGetMenuCateroriesLoadedState) {
          categories = state.categories;
        }
        if (categories.isEmpty) {
          return const SpecialityLoadingList();
        }
        return SizedBox(
          height: 40,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 7),
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ResidnetRestaurantMenuCategoryItem(
                  title: 'all'.tr(context),
                  caterory: 0,
                );
              }
              return ResidnetRestaurantMenuCategoryItem(
                caterory: categories[index - 1].id,
                title: categories[index - 1].nameValue,
              );
            },
          ),
        );
      },
    );
  }
}

class ResidnetRestaurantMenuCategoryItem extends StatelessWidget {
  const ResidnetRestaurantMenuCategoryItem({
    super.key,
    required this.caterory,
    required this.title,
  });

  final String title;
  final int caterory;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentMenuCubit>();
    return InkWell(
      onTap: () {
        cubit.selectMenuCategory(categoryId: caterory);
      },
      child: CategoryFilteritema(
        title: title,
        isSelected: cubit.currentCategoryId == caterory,
      ),
    );
  }
}
