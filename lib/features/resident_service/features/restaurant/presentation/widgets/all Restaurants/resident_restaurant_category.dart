import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/helpers/loadings/speciality_loading_list.dart';
import 'package:wasla/features/auth/data/models/restaurant_catergories_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_speciality_item.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/details/resident_restaurant_cubit.dart';

class ResidnetRestaurantCategory extends StatefulWidget {
  const ResidnetRestaurantCategory({super.key});

  @override
  State<ResidnetRestaurantCategory> createState() =>
      _ResidnetRestaurantCategoryState();
}

class _ResidnetRestaurantCategoryState
    extends State<ResidnetRestaurantCategory> {
  List<RestaurantCatergoriesModel> categories = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentRestaurantCubit, ResidentRestaurantState>(
      buildWhen: (previous, current) =>
          current is GetRestaurantCategoriesLoadingState ||
          current is GetRestaurantCategoriesLoadedState ||
          current is ResidentRestaurantSelectCategoryState,
      builder: (context, state) {
        if (state is GetRestaurantCategoriesLoadingState ||
            state is ResidentRestaurantInitial) {
          return const SpecialityLoadingList();
        }
        if (state is GetRestaurantCategoriesLoadedState) {
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
                return ResidentRestaurantListItem(
                  caterory: RestaurantCatergoriesModel(
                    id: 0,
                    name: 'all'.tr(context),
                  ),
                );
              }
              return ResidentRestaurantListItem(
                caterory: categories[index - 1],
              );
            },
          ),
        );
      },
    );
  }
}

class ResidentRestaurantListItem extends StatelessWidget {
  const ResidentRestaurantListItem({super.key, required this.caterory});
  final RestaurantCatergoriesModel caterory;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentRestaurantCubit>();
    return InkWell(
      onTap: () {
        cubit.selectCategory(categoryId: caterory.id);
      },
      child: CategoryFilteritema(
        title: caterory.name,
        isSelected: cubit.categoryId == caterory.id,
      ),
    );
  }
}
