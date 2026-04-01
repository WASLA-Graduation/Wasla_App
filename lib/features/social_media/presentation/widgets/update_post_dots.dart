import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/post_dots_indicator.dart';

class UpdatePostDots extends StatelessWidget {
  const UpdatePostDots({super.key, required this.length, required this.postId});

  final int length;
  final int postId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();

    return BlocBuilder<SocialMediaCubit, SocialMediaState>(
      buildWhen: (previous, current) => current is UpdateCurrentPostDotIndex,
      builder: (context, state) {
        return length > 1
            ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: PostDotsIndicator(
                  length: length,
                  currentIndex: cubit.postDotIndex[postId] ?? 0,
                ),
              )
            : const SizedBox();
      },
    );
  }
}
