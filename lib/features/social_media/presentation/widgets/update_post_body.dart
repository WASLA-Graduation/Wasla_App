import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/update_post_dots.dart';
import 'package:wasla/features/social_media/presentation/widgets/update_post_images.dart';

class UpdatePostBody extends StatelessWidget {
  const UpdatePostBody({super.key, required this.post});
  final SocialPostModel post;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return Column(
      children: [
        TextFormField(
          initialValue: post.content,
          onChanged: (value) => cubit.postContent = value,
          maxLines: 10,
          minLines: 1,
          decoration: InputDecoration(
            hintText: "saySomething".tr(context),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 15),
        BlocBuilder<SocialMediaCubit, SocialMediaState>(
          buildWhen: (previous, current) => current is UpateChoosedImages,
          builder: (context, state) {
            return Column(
              children: [
                cubit.updatePostModel.newImages.length +
                            cubit.updatePostModel.oldImages.length >
                        0
                    ? UpdatePostImages(post: post)
                    : const SizedBox(),
                UpdatePostDots(
                  postId: post.postId,
                  length:
                      cubit.updatePostModel.newImages.length +
                      cubit.updatePostModel.oldImages.length,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
