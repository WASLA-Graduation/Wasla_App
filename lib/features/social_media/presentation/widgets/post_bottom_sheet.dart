import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/review_action.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/reviews/data/models/review_bottom_sheet_model.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/views/update_post_view.dart';

class PostBottomSheet extends StatelessWidget {
  const PostBottomSheet({super.key, required this.post});

  final SocialPostModel post;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          UnderLineWidget(),
          ...List.generate(
            ReviewBottomSheetModel.commentOptions.length - 1,
            (index) => InkWell(
              onTap: () async {
                Navigator.pop(context);
                switch (ReviewBottomSheetModel.commentOptions[index].action) {
                  case ReviewAction.edit:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePostView(post: post),
                      ),
                    );

                    break;
                  case ReviewAction.delete:
                    cubit.deletePost(myPost: post);

                  case ReviewAction.copy:
                    break;
                }
              },
              child: Row(
                children: [
                  Icon(
                    ReviewBottomSheetModel.commentOptions[index].icon,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    ReviewBottomSheetModel.commentOptions[index].title.tr(
                      context,
                    ),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
