import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/notifications/presentation/cubit/notification_cubit.dart';

class CustomHomeAppBar extends StatefulWidget {
  const CustomHomeAppBar({
    super.key,
    required this.isLoading,
    this.userName,
    this.imageUrl,
    this.showBookmark = true,
    this.onBookmarkTap,
  });

  final bool isLoading;
  final String? userName;
  final String? imageUrl;

  final bool showBookmark;
  final VoidCallback? onBookmarkTap;

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  @override
  void initState() {
    getLastSeenCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = SizeConfig.isTablet;
    final double imageSize = isTablet?70:44;
    final cubit = context.read<NotificationCubit>();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: widget.isLoading
          ? Skeletonizer(child: _buildCircleAvatarLoading())
          : ClipOval(
              child: CustomCachedNetworkImage(
                imageUrl: widget.imageUrl ?? '',
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
              ),
            ),
      title: widget.isLoading
          ? Skeletonizer(child: _buildSubTitle(context))
          : Text(
              widget.userName ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
      subtitle: _buildSubTitle(context),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<NotificationCubit, NotificationState>(
            buildWhen: (previous, current) =>
                current is GetLastSeenCountNotificationaSuccess,
            builder: (context, state) {
              return Stack(
                children: [
                  _buildIcon(
                    size: 25,
                    context,
                    asset: Assets.assetsImagesNotification,
                    onTap: () {
                      context
                          .read<NotificationCubit>()
                          .markAsReadLastSeenNotifications();
                      context.pushScreen(AppRoutes.notificationsScreen);
                    },
                  ),
                  if (context
                          .read<NotificationCubit>()
                          .totoalLastSeenNotifications >
                      0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(
                          cubit.totoalLastSeenNotifications < 10 ? 4 : 2,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          context
                              .read<NotificationCubit>()
                              .totoalLastSeenNotifications
                              .toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: cubit.totoalLastSeenNotifications < 10
                                ? 12
                                : 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          if (widget.showBookmark) ...[
            const SizedBox(width: 12),
            _buildIcon(
              context,
              asset: Assets.assetsImagesHeartOutline,
              onTap: widget.onBookmarkTap,
            ),
          ],
        ],
      ),
    );
  }

  void getLastSeenCount() async {
    context.read<NotificationCubit>().getLastSeenNotificationsCount();
  }

  Widget _buildIcon(
    BuildContext context, {
    required String asset,
    VoidCallback? onTap,
    double size = 22,
  }) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        asset,
        width: size,
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Text _buildSubTitle(BuildContext context) {
    return Text(
      "welcomeBack".tr(context),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  CircleAvatar _buildCircleAvatarLoading() {
    
    return  CircleAvatar(
      radius:SizeConfig.isMobile?35:22 ,
      backgroundImage: AssetImage(Assets.assetsImagesMale),
    );
  }
}
