import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/social_media/data/models/social_comment_model.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class UpdateCommentView extends StatelessWidget {
  const UpdateCommentView({super.key, required this.comment});
  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('editComment'.tr(context))),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Align(
          alignment: Alignment.bottomCenter,

          child: BlocConsumer<SocialMediaCubit, SocialMediaState>(
            listener: (context, state) {
              if (state is UpdateCommentSuccess) {
                Navigator.pop(context);
              } else if (state is UpdateCommentFailure) {
                toastAlert(color: AppColors.error, msg: state.errorMessage);
              }
            },
            builder: (context, state) {
              return UpdateTextField(comment: comment);
            },
          ),
        ),
      ),
    );
  }
}

class UpdateTextField extends StatefulWidget {
  const UpdateTextField({super.key, required this.comment});

  final CommentModel comment;

  @override
  State<UpdateTextField> createState() => _UpdateTextFieldState();
}

class _UpdateTextFieldState extends State<UpdateTextField> {
  @override
  void initState() {
    initComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return TextFormField(
      minLines: 1,
      initialValue: widget.comment.content,
      onChanged: (value) {
        setState(() {});
        cubit.commentContent = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          onPressed: () {
            if (cubit.commentContent.trim().isNotEmpty) {
              cubit.updateComment(comment: widget.comment);
              FocusScope.of(context).unfocus();
            }
          },
          icon: Image.asset(
            cubit.commentContent.trim().isEmpty
                ? Assets.assetsImagesSendOutlined
                : Assets.assetsImagesSendFilled,
            width: 25,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  void initComment() {
    context.read<SocialMediaCubit>().commentContent = widget.comment.content;
  }
}
