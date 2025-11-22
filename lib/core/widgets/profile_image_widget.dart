import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class ProfileImageWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileImageWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Center(
          child: Stack(
            children: [
              state is ProfileGetProfileLoading
                  ? Skeletonizer(
                      child: CircleAvatar(
                        radius: 47,
                        backgroundColor: AppColors.gray.withOpacity(0.1),
                      ),
                    )
                  : ClipOval(
                      child: CustomCachedNetworkImage(
                        imageUrl: cubit.user!.imageUrl,
                        width: 95,
                        height: 95,
                        fit: BoxFit.cover,
                        errorWidget: _buildErrorWidget(),
                        loadingWidget: _buildLoadingWidget(),
                      ),
                    ),
              _buildEditWidget(),
            ],
          ),
        );
      },
    );
  }

  Container _buildLoadingWidget() {
    return Container(
      width: 95,
      height: 95,
      color: AppColors.grayDark.withOpacity(0.1),
    );
  }

  Container _buildErrorWidget() {
    return Container(
      width: 95,
      height: 95,
      color: AppColors.grayDark.withOpacity(0.1),
      child: Icon(Icons.error, color: AppColors.primaryColor, size: 40),
    );
  }

  Positioned _buildEditWidget() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: InkWell(
          onTap: onTap,
          child: Image.asset(
            Assets.assetsImagesEdit,
            height: 18,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
