import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/features/resident_service/features/home/data/models/category_service_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_service_category_item.dart';

class CustomServiceCategoryList extends StatelessWidget {
  const CustomServiceCategoryList({super.key, required this.listLength});

  final int listLength;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: listLength,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () =>
              context.pushScreen(CategoryServiceModel.categories[index].route),
          child: CustomServiceCategoryItem(
            service: CategoryServiceModel.categories[index],
          ),
        );
      },
    );
  }
}
