import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_review_text_field.dart';

class CustomAddReviweWidget extends StatelessWidget {
  const CustomAddReviweWidget({super.key, required this.serviceProviderId});

  final String serviceProviderId;

  @override
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewsCubit>();
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        return Column(
          spacing: 10,
          children: [
            Row(
              spacing: 5,
              children: List.generate(5, (index) {
                return InkWell(
                  onTap: () {
                    cubit.toggleRatingStars(index + 1);
                  },
                  child: Icon(
                    Icons.star,
                    color: cubit.starsIds.contains(index + 1)
                        ? AppColors.primaryColor
                        : AppColors.gray,
                    size: 22,
                  ),
                );
              }),
            ),

            ReviewInputField(
              controller: cubit.reviewValueController,
              hintText: "writeReview".tr(context),
              onChanged: (value) {
                cubit.updateReviewValue(value);
              },
              onSend: () async {
                if (cubit.reviewValue.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  cubit.reviewValueController.clear();
                  await cubit.addReview(serviceProviderId);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
