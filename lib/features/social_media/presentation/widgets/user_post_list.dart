import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/widgets/post_item.dart';

class UserPostsList extends StatelessWidget {
  const UserPostsList({
    super.key,
    required this.posts,
    required this.onRefresh,
  });

  final List<SocialPostModel> posts;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            "noPosts".tr(context),
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return PaginationListener(
      onLoadMore: onRefresh,
      child: SliverList.separated(
        itemCount: posts.length,
        separatorBuilder: (context, index) =>
            Divider(height: 30, color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          return PostItem(post: posts[index]);
        },
      ),
    );
  }
}
