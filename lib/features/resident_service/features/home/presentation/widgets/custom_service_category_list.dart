import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/home/data/models/category_service_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_service_category_item.dart';

class CustomServiceCategoryList extends StatelessWidget {
  const CustomServiceCategoryList({super.key, required this.listLength});

  final int listLength;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      spacing: 20,
      children: List.generate(
        listLength,
        (index) => InkWell(
          onTap: () {},
          child: CustomServiceCategoryItem(
            service: CategoryServiceModel.categories[index],
          ),
        ),
      ),
    );
  }
}
