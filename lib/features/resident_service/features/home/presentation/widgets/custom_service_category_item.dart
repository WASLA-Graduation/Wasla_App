import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/resident_service/features/home/data/models/category_service_model.dart';

class CustomServiceCategoryItem extends StatelessWidget {
  const CustomServiceCategoryItem({super.key, required this.service});

  final CategoryServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: SizeConfig.screenWidth / 6,
          height: SizeConfig.screenWidth / 6,
          decoration: BoxDecoration(
            color: service.color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            service.img,
            color: service.color,
          ),
        ),
        SizedBox(height: 10),
        Text(service.name, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
