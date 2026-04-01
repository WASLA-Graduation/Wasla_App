import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/widgets/post_item.dart';

class PostList extends StatelessWidget {
  const PostList({super.key, required this.posts, required this.onRefresh});
  final List<SocialPostModel> posts;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: onRefresh,
      child: posts.isEmpty
          ? Center(
              child: Text(
                "noPosts".tr(context),
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) =>
                  Divider(height: 30, color: Colors.grey.shade300),
              itemCount: posts.length,
              itemBuilder: (_, index) => PostItem(post: posts.elementAt(index)),
            ),
    );
  }
}
