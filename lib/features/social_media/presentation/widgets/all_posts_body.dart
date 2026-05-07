import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/posts_list.dart';
import 'package:wasla/features/social_media/presentation/widgets/social_app_bar.dart';

class AllPostsBody extends StatelessWidget {
  const AllPostsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.marginDefault,
        vertical: AppSizes.paddingSizeSmall,
      ),
      child: Column(
        spacing: 30,
        children: [
          SocialAppBar(),
          BlocBuilder<SocialMediaCubit, SocialMediaState>(
            buildWhen: (previous, current) =>
                current is GetAllPostsLoading ||
                current is GetAllPostsSuccess ||
                current is DeletePostFailure ||
                current is DeletePostLoading,
            builder: (context, state) {
              if (state is GetAllPostsLoading || state is SocialMediaInitial) {
                return Expanded(
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.primaryColor,
                      size: 50.0,
                    ),
                  ),
                );
              }
              return Expanded(
                child: PostList(
                  onRefresh: () => context.read<SocialMediaCubit>().getAllPosts(
                    fromPagination: true,
                  ),
                  posts: context.read<SocialMediaCubit>().allPosts,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
