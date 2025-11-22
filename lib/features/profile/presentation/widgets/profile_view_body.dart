import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_image_from_device.dart';
import 'package:wasla/core/widgets/custom_choose_image_widget.dart';
import 'package:wasla/core/widgets/profile_image_widget.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/custom_logout_widget.dart';
import 'package:wasla/features/profile/presentation/widgets/custom_profile_appbar.dart';
import 'package:wasla/features/profile/presentation/widgets/profile_list.dart';
import 'package:wasla/features/profile/presentation/widgets/user_name_email_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: CustomProfileAppbar()),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: _buildProfileImage(context)),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(child: UserNameAndEmailWidget()),
          ProfileList(),
          SliverToBoxAdapter(child: CustomLogoutWidget()),
        ],
      ),
    );
  }

  ProfileImageWidget _buildProfileImage(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return ProfileImageWidget(
      onTap: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) => CustomChooseImageWidget(
            cameraOnPressed: () async {
              File? image = await getImageFromMobile(fromGallary: false);
              if (image != null) {
                cubit.image = image;
                cubit.updateResidentInfo();
              }
              context.popScreen();
            },
            galaryOnPressed: () async {
              File? image = await getImageFromMobile(fromGallary: true);
              if (image != null) {
                cubit.image = image;
                cubit.updateResidentInfo();
              }
              context.popScreen();
            },
          ),
        );
      },
    );
  }


}


