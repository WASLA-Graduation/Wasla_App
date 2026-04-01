import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class UpdatePostImages extends StatelessWidget {
  const UpdatePostImages({super.key, required this.post});

  final SocialPostModel post;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    final list = [
      ...cubit.updatePostModel.oldImages,
      ...cubit.updatePostModel.newImages,
    ];

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: PageView.builder(
        onPageChanged: (value) {
          cubit.onPostImageChange(index: value, postId: post.postId);
        },
        itemCount: list.length,
        itemBuilder: (context, index) => Stack(
          children: [
            if (list[index] is File)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: Image.file(list[index] as File, fit: BoxFit.cover),
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: CustomCachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: post.files[index],
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(-40, 0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  onPressed: () {
                    cubit.deletePostImage(image: list[index]);
                  },
                  icon: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 13,
                    child: const Icon(
                      size: 15,
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                onPressed: () {
                  pickMultipleImages().then(
                    (images) => cubit.updatePostImages(newImages: images),
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 13,
                  child: Icon(size: 18, Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
