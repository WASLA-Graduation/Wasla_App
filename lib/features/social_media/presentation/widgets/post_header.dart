import 'package:flutter/material.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/widgets/post_bottom_sheet.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({super.key, required this.post});
  final SocialPostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleNeworkImage(
          imageUrl: post.profilePhoto,
          onTap: () {
            if (post.userId.isNotEmpty) {
                context.pushScreen(
                  AppRoutes.socialProfileScreen,
                  arguments: {
                    AppStrings.name: post.userName,
                    AppStrings.id: post.userId,
                  },
                );
              }
          },
          isLoading: false,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: InkWell(
            onTap: () {
              if (post.userId.isNotEmpty) {
                context.pushScreen(
                  AppRoutes.socialProfileScreen,
                  arguments: {
                    AppStrings.name: post.userName,
                    AppStrings.id: post.userId,
                  },
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),

                const SizedBox(height: 4),

                Text(
                  formateDateToMatchWithPosts(post.createdAt),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),

        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () async {
            final String? currentUserId = await getUserId();
            if (currentUserId == post.userId || post.userId.isEmpty) {
              showModalBottomSheet(
                context: context,
                builder: (context) => PostBottomSheet(post: post),
              );
            }
          },
        ),
      ],
    );
  }
}
