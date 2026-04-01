import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_review_text_field.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    super.key,
    required this.postId,
    required this.onSend,
  });

  final int postId;
  final void Function() onSend;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialMediaCubit>();
    return ReviewInputField(
      controller: cubit.commentController,
      hintText: "addComment".tr(context),
      onChanged: (value) {
        setState(() {});
        cubit.commentContent = value;
      },
      onSend: widget.onSend,
    );
  }
}
