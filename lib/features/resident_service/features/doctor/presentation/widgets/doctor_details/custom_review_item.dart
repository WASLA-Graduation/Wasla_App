
import 'package:flutter/material.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/models/review_model.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_rating_widget.dart';

class CustomReviewItem extends StatelessWidget {
  const CustomReviewItem({super.key, required this.reviewModel});
  final ReviewModel reviewModel;

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
              rating: reviewModel.rating.toString(),
              isSelected: false,
            ),
            const SizedBox(width: 10),
            CustomMoreAppBarWidget(rightPadding: 0),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ReadmoreText(maxLines: 2, text: reviewModel.comment),
        ),

        _buildReactionWidget(context),
      ],
    );
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
        Text(
          formatDateToCustomString(reviewModel.createdAt),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  Text _title(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      reviewModel.reviewerName,
      style: Theme.of(
        context,
      ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  ClipOval _leading() {
    return ClipOval(
      child: CustomCachedNetworkImage(
        imageUrl: reviewModel.userImageUrl,
        height: 44,
        width: 44,
      ),
    );
  }
}
