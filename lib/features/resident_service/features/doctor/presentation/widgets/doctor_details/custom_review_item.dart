import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_rating_widget.dart';

class CustomReviewItem extends StatelessWidget {
  const CustomReviewItem({super.key, this.ratingIndex});
  final int? ratingIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          children: [
            _leading(),
            const SizedBox(width: 10),
            Expanded(child: _title(context)),
            CustomRatingWidget(
              rating: ratingIndex == null || ratingIndex == 0
                  ? randomOneToFive().toString()
                  : ratingIndex.toString(),
              isSelected: false,
            ),
            const SizedBox(width: 10),
            CustomMoreAppBarWidget(rightPadding: 0),
          ],
        ),
        ReadmoreText(
          maxLines: 2,
          text:
              "The doctor is very professional and caring Always makes me feel comfortable and listened to 💖💙",
        ),

        _buildReactionWidget(context),
      ],
    );
  }

  int randomOneToFive() {
    final r = Random();
    return 1 + r.nextInt(5); // nextInt(5) => 0..4
  }

  Row _buildReactionWidget(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.assetsImagesFavourite,
          color: AppColors.primaryColor,
          height: 20,
        ),
        const SizedBox(width: 10),

        Text("923", style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(width: 15),

        Text("6 days ago", style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }

  Text _title(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      "Mostafa Salah",
      style: Theme.of(
        context,
      ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  CircleAvatar _leading() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.gray.withOpacity(0.3),
      backgroundImage: AssetImage(Assets.assetsImagesProfile),
    );
  }
}
