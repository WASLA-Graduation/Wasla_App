import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class SocialAppBar extends StatelessWidget {
  const SocialAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return BlocBuilder<SocialMediaCubit, SocialMediaState>(
      buildWhen: (previous, current) => current is GetUserProfileSuccess,
      builder: (context, state) {
        return Row(
          spacing: 10,
          children: [
            CircleNeworkImage(
              imageUrl: cubit.userProfile?.profilePhoto ?? '',
              onTap: () async {
                if (cubit.userProfile != null) {
                  final String? currentUser = await getUserId();
                  context.pushScreen(
                    AppRoutes.socialProfileScreen,
                    arguments: {
                      AppStrings.name: cubit.userProfile?.userName ?? '',
                      AppStrings.id: currentUser,
                    },
                  );
                }
              },
              isLoading: cubit.userProfile == null,
            ),
            Expanded(child: _buildTextField(context)),
            // _buildNotificationIcon(context),
          ],
        );
      },
    );
  }

  TextField _buildTextField(BuildContext context) {
    return TextField(
      readOnly: true,

      onTap: () {
        context.pushScreen(AppRoutes.addPostsScreen);
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.titleSmall,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        filled: false,
        focusedBorder: _buildBorder(),
        border: _buildBorder(),
        hintText: 'whatsInYourMind'.tr(context),
      ),
    );
  }

  // InkWell _buildNotificationIcon(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       context.pushScreen(AppRoutes.notificationsScreen);
  //     },
  //     child: Image.asset(
  //       Assets.assetsImagesNotification,
  //       width: 22,
  //       color: context.isDarkMode ? Colors.white : Colors.black,
  //     ),
  //   );
  // }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(color: AppColors.gray, width: 1),
    );
  }
}
