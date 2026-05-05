import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
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
        child: BlocStatusHandler<SocialMediaCubit, SocialMediaState>(
          body: const AllPostsBody(),
          onRetry: () {
            context.read<SocialMediaCubit>().onRetry();
            getAllPosts();
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

  void getAllPosts() async {
    final cubit = context.read<SocialMediaCubit>();
    cubit.reset();
    await cubit.getCurrentUser();
    cubit.getUserProfile(userId: cubit.currentUser);
    cubit.getAllPosts(fromPagination: false);
  }
}
