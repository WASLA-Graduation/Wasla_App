import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class AddPostBody extends StatelessWidget {
  const AddPostBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();

    return Column(
      children: [
        TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onChanged: (value) => cubit.postContent = value,
          maxLines: 10,
          minLines: 1,
          decoration: InputDecoration(
            hintText: "saySomething".tr(context),
            border: InputBorder.none,
          ),
        ),

        const SizedBox(height: 12),
        BlocBuilder<SocialMediaCubit, SocialMediaState>(
          buildWhen: (previous, current) => current is UpateChoosedImages,
          builder: (context, state) {
            final images = cubit.postsImages;
            return images.isEmpty
                ? const Spacer()
                : PostImagesLayout(images: images);
          },
        ),
        const SizedBox(height: 12),

        InkWell(
          onTap: () {
            pickMultipleImages().then(
              (images) => cubit.updateChoosedPostImages(images),
            );
          },
          child: Row(
            spacing: 10,
            children: [
              Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
                size: 23,
              ),

              Text(
                'Photos',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: AppColors.primaryColor, thickness: .1),
        const SizedBox(height: 20),
      ],
    );
  }
}

class PostImagesLayout extends StatelessWidget {
  final List<File> images;
  final double spacing;

  const PostImagesLayout({super.key, required this.images, this.spacing = 2});

  @override
  Widget build(BuildContext context) {
    return _buildLayout();
  }

  Widget _buildLayout() {
    switch (images.length) {
      case 1:
        return Expanded(child: _OneImage(images: images));
      case 2:
        return Expanded(child: _TwoImages(images: images));
      case 3:
        return Expanded(child: _ThreeImages(images: images));
      case 4:
        return Expanded(
          child: _FourImages(images: images, spacing: spacing),
        );
      default:
        return Expanded(
          child: _MoreImages(images: images, spacing: spacing),
        );
    }
  }
}

class _OneImage extends StatelessWidget {
  final List<File> images;

  const _OneImage({required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Image.file(images.first, fit: BoxFit.contain),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _TwoImages extends StatelessWidget {
  final List<File> images;

  const _TwoImages({required this.images});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: images
          .map((img) => Expanded(child: Image.file(img, fit: BoxFit.cover)))
          .toList(),
    );
  }
}

class _ThreeImages extends StatelessWidget {
  final List<File> images;

  const _ThreeImages({required this.images});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Image.file(images[0], fit: BoxFit.cover)),
        Expanded(
          child: Column(
            spacing: 10,
            children: [
              Expanded(child: Image.file(images[1], fit: BoxFit.cover)),
              Expanded(child: Image.file(images[2], fit: BoxFit.cover)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FourImages extends StatelessWidget {
  final List<File> images;
  final double spacing;

  const _FourImages({required this.images, required this.spacing});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(spacing / 2),
            child: Image.file(images[index], fit: BoxFit.fill),
          );
        },
      ),
    );
  }
}

class _MoreImages extends StatelessWidget {
  final List<File> images;
  final double spacing;

  const _MoreImages({required this.images, required this.spacing});

  @override
  Widget build(BuildContext context) {
    final remaining = images.length - 4;

    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          if (index == 3) {
            return Padding(
              padding: EdgeInsets.all(spacing / 2),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(images[index], fit: BoxFit.fill),
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        "+$remaining",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(spacing / 2),
            child: Image.file(images[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
