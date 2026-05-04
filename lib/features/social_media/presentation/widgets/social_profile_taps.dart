import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/social_enums.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_resident_booking_taps.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class SocialProfileTaps extends StatelessWidget {
  const SocialProfileTaps({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return BlocBuilder<SocialMediaCubit, SocialMediaState>(
      buildWhen: (previous, current) => current is GetUserPostsLoading,
      builder: (context, state) {
        return cubit.currentUser != userId
            ? SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(PostType.values.length, (index) {
                  return CustomTapWidget(
                    isSelected: cubit.userProfileCurrentTap == index,
                    title: PostType.getTapName(index).tr(context),
                    onTap: () {
                      cubit.changeTapIndex(
                        index: index,
                        postType: PostType.values[index],
                        userId: userId,
                      );
                    },
                  );
                }),
              );
      },
    );
  }
}
