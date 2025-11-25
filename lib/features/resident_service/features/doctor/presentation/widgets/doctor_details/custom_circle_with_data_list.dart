import 'package:flutter/material.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_circle_with_data.dart';

class CustomCircleWithDataList extends StatelessWidget {
  CustomCircleWithDataList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return Expanded(
          child: CircleAvatarWithDetailsWidget(
            icon: icons[index],
            title: titles[index],
            num: numsString[index],
          ),
        );
      }),
    );
  }

  final List<String> icons = [
    Assets.assetsImagesGroup,
    Assets.assetsImagesMessanger,
    Assets.assetsImagesHalfStar,
    Assets.assetsImagesChatFilled,
  ];
  final List<String> titles = ["patients", "experience", "rating", "reviews"];
  final List<String> numsString = ["5,000+", "10+", "4.8", "4.942"];
}
