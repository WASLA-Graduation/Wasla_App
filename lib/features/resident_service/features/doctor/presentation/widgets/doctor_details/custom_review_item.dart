import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/core/widgets/readmore_text.dart';

class CustomReviewItem extends StatelessWidget {
  const CustomReviewItem({super.key});

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
            _buildTrailing(context),
            const SizedBox(width: 10),
            CustomMoreAppBarWidget(rightPadding: 0),
          ],
        ),
        ReadmoreText(
          maxLines: 2,
          text:
              "The doctor is very professional and caring Always makes me feel comfortable and listened to 💖💙",
        ),
      ],
    );
  }

  Container _buildTrailing(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(width: 1, color: AppColors.primaryColor),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: AppColors.primaryColor, size: 18),
          const SizedBox(width: 6),
          Text(
            "4",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
