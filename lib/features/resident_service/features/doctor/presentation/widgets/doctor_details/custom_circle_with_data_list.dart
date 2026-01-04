import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_circle_with_data.dart';

class CustomCircleWithDataList extends StatelessWidget {
  CustomCircleWithDataList({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return Expanded(
          child: CircleAvatarWithDetailsWidget(
            icon: icons[index],
            title: titles[index].tr(context).toLowerCase(),
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
  final List<String> titles = ["patients", "experience", "rating", "reviwes"];
  late final List<String> numsString = [
    "${doctor.numberOfpatients.toString()}+",
    "${doctor.experienceYears.toString()}+",
    (doctor.rating.toStringAsPrecision(2)),
    ("100+"),
  ];
}
