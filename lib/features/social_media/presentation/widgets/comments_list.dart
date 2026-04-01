import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/social_media/data/models/social_comment_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/comment_item.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.comments, required this.postId});
  final List<CommentModel> comments;
  final int postId;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: () async {
        context.read<SocialMediaCubit>().getPostComments(
          fromPagination: true,
          postId: postId,
        );
      },
      child: comments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "noComments".tr(context),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "writeComment".tr(context),
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: comments.length,
              itemBuilder: (context, index) =>
                  CommentItem(comment: comments[index], postId: postId),
            ),
    );
  }
}
