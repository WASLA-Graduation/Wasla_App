import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class DoctorListItemDescriptionWidget extends StatelessWidget {
  const DoctorListItemDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        Divider(height: 20, color: AppColors.primaryColor, thickness: .1),
        _buildSpecialityWidget(context),
        const SizedBox(height: 10),
        _buildReviwesWidget(context),
      ],
    );
  }

  Text _buildSpecialityWidget(BuildContext context) {
    return Text(
      "Dentist | Christ Hospital",
      style: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
    );
  }

  Row _buildTitleWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "Dr.Randy",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Spacer(),
        InkWell(
          child: Image.asset(
            Assets.assetsImagesHeartOutline,
            width: 18,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Row _buildReviwesWidget(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.primaryColor, size: 18),
        const SizedBox(width: 6),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "4.5  (4,577 reviwes)",
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}
