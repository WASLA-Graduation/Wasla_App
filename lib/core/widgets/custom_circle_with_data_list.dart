import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_circle_with_data.dart';

class CustomCircleWithDataList extends StatelessWidget {
  const CustomCircleWithDataList({
    super.key,
    required this.items,
  });

  final List<CircleStatModel> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        items.length,
        (index) => Expanded(
          child: CircleAvatarWithDetailsWidget(
            icon: items[index].icon,
            title: items[index].title,
            num: items[index].value,
          ),
        ),
      ),
    );
  }
}



class CircleStatModel {
  final String icon;
  final String title;
  final String value;

  const CircleStatModel({
    required this.icon,
    required this.title,
    required this.value,
  });
}

