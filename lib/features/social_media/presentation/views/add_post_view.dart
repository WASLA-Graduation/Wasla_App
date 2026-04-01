import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/add_post_body.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  @override
  void initState() {
    super.initState();
    resetPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addPost'.tr(context)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlocConsumer<SocialMediaCubit, SocialMediaState>(
              buildWhen: (previous, current) =>
                  current is AddPostSuccess ||
                  current is AddPostFailure ||
                  current is AddPostLoading,
              listener: (context, state) {
                if (state is AddPostSuccess) {
                  toastAlert(
                    color: AppColors.primaryColor,
                    msg: 'postAdded'.tr(context),
                  );
                  Navigator.pop(context);
                } else if (state is AddPostFailure) {
                  toastAlert(
                    color: AppColors.error,
                    msg: 'somethingWentWrong'.tr(context),
                  );
                }
              },

              builder: (context, state) {
                return TextButton(
                  onPressed: () async {
                    await context.read<SocialMediaCubit>().addPost();
                  },
                  child: Text(
                    state is AddPostLoading
                        ? 'loading'.tr(context)
                        : 'save'.tr(context),
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: const AddPostBody(),
      ),
    );
  }

  void resetPage() {
    context.read<SocialMediaCubit>().reset();
  }
}
