import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/profile_statistcs_widget.dart';
import 'package:wasla/features/social_media/presentation/widgets/right_post_list.dart';
import 'package:wasla/features/social_media/presentation/widgets/social_profile_photo_and_name.dart';
import 'package:wasla/features/social_media/presentation/widgets/social_profile_taps.dart';

class SocialProfileBody extends StatelessWidget {
  const SocialProfileBody({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<SocialMediaCubit, SocialMediaState>(
              buildWhen: (previous, current) =>
                  current is GetUserProfileLoading ||
                  current is GetUserProfileSuccess,
              builder: (context, state) {
                return SocailProfilePhotoAndName(
                  profile: context.read<SocialMediaCubit>().userProfile,
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: IntrinsicHeight(
              child: BlocBuilder<SocialMediaCubit, SocialMediaState>(
                buildWhen: (previous, current) =>
                    current is GetUserProfileLoading ||
                    current is GetUserProfileSuccess,
                builder: (context, state) {
                  final cubit = context.read<SocialMediaCubit>();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileStaticsWidget(
                        title: "posts".tr(context),
                        value:
                            cubit.userProfile?.postsCount.toString() ?? '...',
                      ),
                      const VerticalDivider(thickness: 1),
                      ProfileStaticsWidget(
                        title: "likes".tr(context),
                        value:
                            cubit.userProfile?.reactionsCount.toString() ??
                            '...',
                      ),
                      const VerticalDivider(thickness: 1),
                      ProfileStaticsWidget(
                        title: "saves".tr(context),
                        value: cubit.userProfile?.savesCount.toString() ?? '...',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: const Divider(height: 30)),
          SliverToBoxAdapter(child: SocialProfileTaps(userId: userId)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          RightPostList(userId: userId),
        ],
      ),
    );
  }
}
