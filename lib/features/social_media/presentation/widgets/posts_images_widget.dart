import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/post_dots_indicator.dart';

class PostsImagesWidget extends StatelessWidget {
  const PostsImagesWidget({super.key, required this.post});

  final SocialPostModel post;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    final list = [...post.files, ...post.newImages];

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                cubit.onPostImageChange(index: value, postId: post.postId);
              },
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (list[index] is File) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(list[index] as File, fit: BoxFit.cover),
                  );
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomCachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: post.files[index],
                    ),
                  );
                }
              },
            ),
          ),
          BlocBuilder<SocialMediaCubit, SocialMediaState>(
            buildWhen: (previous, current) =>
                current is UpdateCurrentPostDotIndex &&
                post.postId == cubit.selectedPostId,
            builder: (context, state) {
              return list.length > 1
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: PostDotsIndicator(
                        length: list.length,
                        currentIndex: cubit.postDotIndex[post.postId] ?? 0,
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
