import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/all_posts_body.dart';

class AllPostsView extends StatefulWidget {
  const AllPostsView({super.key});

  @override
  State<AllPostsView> createState() => _AllPostsViewState();
}

class _AllPostsViewState extends State<AllPostsView> {
  @override
  void initState() {
    getAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: const AllPostsBody(),
        ),
      ),
    );
  }

  void getAllPosts() async {
    final cubit = context.read<SocialMediaCubit>();
    cubit.reset();
    final String? userId = await getUserId();
    await cubit.getAllPosts(fromPagination: false);
    cubit.getUserProfile(userId: userId!);
  }
}
