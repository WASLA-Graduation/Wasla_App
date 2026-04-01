import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_strings.dart';
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
        forceMaterialTransparency: true,

        title: Text(widget.userData[AppStrings.name]),
      ),

      body: SocialProfileBody(userId: widget.userData[AppStrings.id]),
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
