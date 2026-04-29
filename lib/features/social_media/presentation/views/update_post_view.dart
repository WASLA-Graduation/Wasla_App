import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/social_media/presentation/widgets/update_post_body.dart';

class UpdatePostView extends StatefulWidget {
  const UpdatePostView({super.key, required this.post});

  final SocialPostModel post;

  @override
  State<UpdatePostView> createState() => _UpdatePostViewState();
}

class _UpdatePostViewState extends State<UpdatePostView> {
  @override
  void initState() {
    super.initState();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('editPost'.tr(context)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlocConsumer<SocialMediaCubit, SocialMediaState>(
              listener: (context, state) {
                if (state is UpdatePostFailure) {
                  toastAlert(
                    color: AppColors.red,
                    msg: 'somethingWentWrong'.tr(context),
                  );
                } else if (state is UpdatePostSuccess) {
                  toastAlert(
                    color: AppColors.primaryColor,
                    msg: 'postUpdated'.tr(context),
                  );
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () async {
                    context.read<SocialMediaCubit>().updatePost(
                      postId: widget.post.postId,
                    );
                  },
                  child: state is UpdatePostLoading
                      ? Text(
                          'loading'.tr(context),
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        )
                      : Icon(
                          Icons.done,
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                );
              },
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: UpdatePostBody(post: widget.post),
      ),
    );
  }

  void reset() {
    final cubit = context.read<SocialMediaCubit>();
    cubit.postDotIndex = {};
    cubit.selectedPostId = -1;
    cubit.updatePostImages(newImages: [], oldImages: widget.post.files);
    cubit.postContent = widget.post.content;
  }
}
