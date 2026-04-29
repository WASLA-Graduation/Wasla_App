import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/comment_text_field.dart';
import 'package:wasla/features/social_media/presentation/widgets/comments_list.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key, required this.postId});

  final int postId;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  @override
  void initState() {
    super.initState();
    getPostComments();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Container(
        height: SizeConfig.screenHeight * 0.9,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              const UnderLineWidget(),

              const SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<SocialMediaCubit, SocialMediaState>(
                  buildWhen: (previous, current) =>
                      current is GetCommentsLoading ||
                      current is GetCommentsSuccess ||
                      current is DeleteCommentFailure ||
                      current is DeleteCommentLoading,
                  builder: (context, state) {
                    if (state is GetCommentsLoading) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 50,
                        ),
                      );
                    }

                    return CommentsList(
                      postId: widget.postId,
                      comments: cubit.postComments,
                    );
                  },
                ),
              ),

              CommentTextField(
                postId: widget.postId,
                onSend: () async {
                  if (cubit.commentContent.isNotEmpty) {
                    FocusScope.of(context).unfocus();
                    cubit.commentController.clear();
                    cubit.addComment(postId: widget.postId);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getPostComments() {
    final cubit = context.read<SocialMediaCubit>();

    cubit.commentPageNumber = 1;
    cubit.commentPageSize = 10;
    cubit.endOfComments = false;
    cubit.postComments = [];

    cubit.getPostComments(postId: widget.postId, fromPagination: false);
  }
}
