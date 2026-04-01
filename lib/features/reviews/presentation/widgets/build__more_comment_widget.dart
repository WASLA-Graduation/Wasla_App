import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/review_action.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/features/reviews/data/models/review_model.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/reviews/presentation/widgets/show_comment_more_bottom_sheet.dart';
import 'package:wasla/features/reviews/presentation/widgets/show_edit_review_dialog.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class BuildMoreCommentWidget extends StatelessWidget {
  const BuildMoreCommentWidget({super.key, required this.reviewModel});

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewsCubit>();

    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listener: (context, state) {
        if (state is DeleteReviewsuccess) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: "reviewDeleted".tr(context),
          );
        } else if (state is UpdateReviewsuccess) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: "reviewUpdated".tr(context),
          );
        } else if (state is DeleteReviewFailure ||
            state is UpdateReviewFailure) {
          toastAlert(
            color: AppColors.error,
            msg: "somethingWentWrong".tr(context),
          );
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            final currentUserId = await getUserId();
            final canDelete =
                currentUserId != null && currentUserId == reviewModel.userId;

            showModalBottomSheet(
              context: context,
              builder: (bottomSheetContext) {
                return ShowCommentMoreBottomSheet(
                  canDelete: canDelete,
                  onActionSelected: (action) async {
                    switch (action) {
                      case ReviewAction.edit:
                        cubit.reviewEditValueController.text =
                            reviewModel.comment;
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return ShowReviewDialog(reviewModel: reviewModel);
                          },
                        );
                        break;

                      case ReviewAction.delete:
                        await cubit.deleteReview(
                          reviewId: reviewModel.reviewId,
                        );
                        break;

                      case ReviewAction.copy:
                        Clipboard.setData(
                          ClipboardData(text: reviewModel.comment),
                        );
                        toastAlert(
                          color: AppColors.primaryColor,
                          msg: "textCopied".tr(context),
                        );
                        break;
                    }
                  },
                );
              },
            );
          },
          child: Image.asset(
            Assets.assetsImagesMore,
            width: 21,
            color: context.isDarkMode
                ? AppColors.whiteColor
                : AppColors.blackColor,
          ),
        );
      },
    );
  }
}
