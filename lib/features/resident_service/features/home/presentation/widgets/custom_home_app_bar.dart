import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeResidentCubit, HomeResidentState>(
      builder: (context, state) {
        final cubit = context.read<HomeResidentCubit>();
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: cubit.user == null
              ? Skeletonizer(child: _buildCircleAvatarLoading())
              : ClipOval(
                  child: CustomCachedNetworkImage(
                    imageUrl: cubit.user!.imageUrl,
                    height: 44,
                    width: 44,
                  ),
                ),
          title: cubit.user == null
              ? Skeletonizer(child: _buildSubTitle(context))
              : Text(
                  cubit.user!.fullName,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
          subtitle: _buildSubTitle(context),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  Assets.assetsImagesNotification,
                  width: 23,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: 12),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  Assets.assetsImagesBookmark,
                  width: 23,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Text _buildSubTitle(BuildContext context) {
    return Text(
      "welcomeBack".tr(context),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  CircleAvatar _buildCircleAvatarLoading() {
    return const CircleAvatar(
      radius: 22,
      backgroundImage: AssetImage(Assets.assetsImagesMale),
    );
  }
}
