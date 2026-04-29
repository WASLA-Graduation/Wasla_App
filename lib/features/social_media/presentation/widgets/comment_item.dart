import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/social_enums.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/social_media/data/models/social_comment_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/comment_long_press_sheet.dart';
import 'package:wasla/features/social_media/presentation/widgets/report_bottom_sheet.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment, required this.postId});
  final CommentModel comment;
  final int postId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return Builder(
      builder: (context) {
        return InkWell(
          onLongPress: () async {
            final String? currentUserId = await getUserId();
            if (currentUserId == comment.userId) {
              showModalBottomSheet(
                context: context,
                builder: (_) =>
                    CommentLongPressSheet(comment: comment, postId: postId),
              );
            } else {
              showModalBottomSheet(
                context: context,
                builder: (context) => ReportBottomSheet(
                  content: comment.content,
                  targetType: TargetType.comment,
                  targetId: comment.commentId,
                ),
              );
            }
          },
          child: Column(
            spacing: 8,
            children: [
              ListTile(
                isThreeLine: true,
                contentPadding: EdgeInsets.zero,
                leading: CircleNeworkImage(
                  imageUrl: comment.userProfile,
                  onTap: () {
                    context.pushScreen(
                      AppRoutes.socialProfileScreen,
                      arguments: {
                        AppStrings.name: comment.userName,

                        AppStrings.id: comment.userId,
                      },
                    );
                  },
                  isLoading: false,
                ),

                title: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.pushScreen(
                          AppRoutes.socialProfileScreen,
                          arguments: {
                            AppStrings.name: comment.userName,

                            AppStrings.id: comment.userId,
                          },
                        );
                      },
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        comment.userName,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),

                    const SizedBox(width: 5),
                    Text(
                      '. ${formateDateToMatchWithPosts(comment.createdAt)}',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                subtitle: BlocBuilder<SocialMediaCubit, SocialMediaState>(
                  buildWhen: (previous, current) =>
                      current is UpdateCommentSuccess &&
                      cubit.selectedPostId == comment.commentId,
                  builder: (context, state) {
                    return ReadmoreText(maxLines: 3, text: comment.content);
                  },
                ),

                trailing: BlocBuilder<SocialMediaCubit, SocialMediaState>(
                  buildWhen: (previous, current) =>
                      current is ToggleReactionState &&
                      cubit.selectedPostId == comment.commentId,
                  builder: (context, state) {
                    return Column(
                      spacing: 3,
                      children: [
                        InkWell(
                          onTap: () async {
                            cubit.toggleReaction(
                              reactionType: ReactionType.love,
                              targetType: TargetType.comment,
                              item: comment,
                            );
                          },
                          child: Image.asset(
                            comment.isLove
                                ? Assets.assetsImagesFavourite
                                : Assets.assetsImagesHeartOutline,
                            height: 20,
                            color: comment.isLove
                                ? AppColors.primaryColor
                                : null,
                          ),
                        ),
                        _buildTextNumber(context, num: comment.numberOfLikes),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Text _buildTextNumber(BuildContext context, {required int num}) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      num.toString(),
      style: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: Colors.grey),
    );
  }
}
