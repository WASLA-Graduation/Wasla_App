import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/enums/social_enums.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/user_post_list.dart';

class RightPostList extends StatefulWidget {
  const RightPostList({super.key, required this.userId});

  final String userId;

  @override
  State<RightPostList> createState() => _RightPostListState();
}

class _RightPostListState extends State<RightPostList> {
  @override
  void initState() {
    super.initState();
    getRightPostList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialMediaCubit, SocialMediaState>(
      buildWhen: (previous, current) =>
          current is GetUserPostsFailure ||
          current is GetUserPostsLoading ||
          current is GetUserPostsSuccess ||
          current is DeletePostFailure ||
          current is DeletePostLoading,
      builder: (context, state) {
        if (state is GetUserPostsFailure) {
          return const SliverFillRemaining(child: CustomErrGetData());
        }

        if (state is GetUserPostsLoading) {
          return SliverFillRemaining(
            child: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
          );
        }

        final posts = context.read<SocialMediaCubit>().userPosts;

        return UserPostsList(posts: posts, onRefresh: refreshPosts);
      },
    );
  }

  void getRightPostList() {
    final cubit = context.read<SocialMediaCubit>();

    cubit.getUserPosts(fromPagination: false, userId: widget.userId);
  }

  void refreshPosts() {
    final cubit = context.read<SocialMediaCubit>();

    switch (PostType.formInt(cubit.userProfileCurrentTap)) {
      case PostType.post:
        cubit.getUserPosts(fromPagination: true, userId: widget.userId);
        break;

      case PostType.love:
        cubit.getUserPostsByReaction(
          fromPagination: true,
          userId: widget.userId,
          reactionType: ReactionType.love,
        );
        break;

      case PostType.save:
        cubit.getUserPostsByReaction(
          fromPagination: true,
          userId: widget.userId,
          reactionType: ReactionType.save,
        );
        break;
    }
  }
}
