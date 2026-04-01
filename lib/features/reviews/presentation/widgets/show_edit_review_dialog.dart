import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/reviews/data/models/review_model.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_review_text_field.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class ShowReviewDialog extends StatelessWidget {
  const ShowReviewDialog({super.key, required this.reviewModel});

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewsCubit>();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: Center(
        child: Text(
          "editReview".tr(context),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      content: ReviewInputField(
        maxLines: 3,
        controller: cubit.reviewEditValueController,
        hintText: "editReview".tr(context),
        onChanged: cubit.updateReviewValue,
        onSend: () async {
          if (cubit.reviewValue.isEmpty) return;
          Navigator.pop(context);
          await cubit.updateReview(selectedReveiw: reviewModel);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "cancel".tr(context),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}
