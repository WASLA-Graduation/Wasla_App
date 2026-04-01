import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/post_footer.dart';
import 'package:wasla/features/social_media/presentation/widgets/post_header.dart';
import 'package:wasla/features/social_media/presentation/widgets/posts_images_widget.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});
  final SocialPostModel post;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 7,
      children: [
        PostHeader(post: post),
        BlocBuilder<SocialMediaCubit, SocialMediaState>(
          buildWhen: (previous, current) =>
              current is UpdatePostSuccess &&
              cubit.selectedPostId == post.postId,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                post.content.isEmpty
                    ? const SizedBox()
                    : ReadmoreText(maxLines: 10, text: post.content),
                const SizedBox(height: 15),
                post.files.isEmpty && post.newImages.isEmpty
                    ? const SizedBox()
                    : PostsImagesWidget(post: post),
              ],
            );
          },
        ),
        const SizedBox(height: 5),
        PostFooter(post: post),
      ],
    );
  }
}
