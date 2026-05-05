import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/service/signalR/chat_hub.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/social_profile_body.dart';

class SocialProfileView extends StatefulWidget {
  final Map<String, dynamic> userData;
  const SocialProfileView({super.key, required this.userData});

  @override
  State<SocialProfileView> createState() => _SocialProfileViewState();
}

class _SocialProfileViewState extends State<SocialProfileView> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          widget.userData[AppStrings.name],
        ),
        actions: [
          Visibility(
            visible:
                context.read<SocialMediaCubit>().currentUser !=
                widget.userData[AppStrings.id],
            child: IconButton(
              onPressed: () async {
                final chatHub = ChatHub();
                chatHub.init();
                await context.push(
                  AppRoutes.chatScreen,
                  extra: {
                    AppStrings.id: widget.userData[AppStrings.id],
                    AppStrings.name: widget.userData[AppStrings.name],
                    AppStrings.photo:
                        context
                            .read<SocialMediaCubit>()
                            .userProfile
                            ?.profilePhoto ??
                        '',
                  },
                );
                chatHub.disconnect();
              },
              icon: Image.asset(
                Assets.assetsImagesChatFilled,
                height: 22,
                width: 22,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocStatusHandler<SocialMediaCubit, SocialMediaState>(
          body: SocialProfileBody(userId: widget.userData[AppStrings.id]),
          onRetry: () {
            context.read<SocialMediaCubit>().onRetry();
            getProfile();
          },
          isNetwork: (state) => state is SocialMediaNetworkState,
          isError: (state) => state is SocialMediaFailureState,
          buildWhen: (previous, current) =>
              current is SocialMediaNetworkState ||
              current is SocialMediaFailureState ||
              current is SocialMediaOnRetryState,
        ),
      ),
    );
  }

  void getProfile() {
    final cubit = context.read<SocialMediaCubit>();
    cubit.userPageSize = 10;
    cubit.userPageNumber = 1;
    cubit.userEndOfPosts = false;
    cubit.userPosts = [];
    cubit.getUserProfile(userId: widget.userData[AppStrings.id]);
  }
}
