import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/review_action.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/models/review_model.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_review/show_comment_more_bottom_sheet.dart';

class BuildMoreCommentWidget extends StatelessWidget {
  const BuildMoreCommentWidget({super.key, required this.reviewModel});
  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is DoctorDeleteReviweSuccess) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: "reviewDeleted".tr(context),
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
              builder: (context) => ShowCommentMoreBottomSheet(
                canDelete: canDelete,
                onActionSelected: (action) async {
                  switch (action) {
                    case ReviewAction.edit:
                      print('Edit pressed');
                      break;

                    case ReviewAction.delete:
                      await cubit.deleteReview(reviewId: reviewModel.reviewId);

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
              ),
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
