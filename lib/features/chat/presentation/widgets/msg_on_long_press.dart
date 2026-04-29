import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/msg_type_enum.dart';
import 'package:wasla/core/enums/review_action.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/reviews/data/models/review_bottom_sheet_model.dart';

class MsgOnLongPress extends StatelessWidget {
  const MsgOnLongPress({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          UnderLineWidget(),
          ...List.generate(
            options.length,
            (index) => InkWell(
              onTap: () async {
                Navigator.pop(context);
                switch (options[index].action) {
                  case ReviewAction.edit:
                
                    cubit.whenUserUpdate(message: message);
                  case ReviewAction.delete:
                    cubit.deleteMsg(msg: message);
                  case ReviewAction.copy:
                    Clipboard.setData(
                      ClipboardData(text: message.messageText ?? ''),
                    ).then((value) {
                      toastAlert(
                        msg: "textCopied".tr(context),
                        color: AppColors.primaryColor,
                      );
                    });
                    break;
                }
              },
              child: Row(
                children: [
                  Icon(
                    options[index].icon,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    options[index].title.tr(context),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  List<ReviewBottomSheetModel> get options =>
      ReviewBottomSheetModel.commentOptions.where((option) {
        switch (option.action) {
          case ReviewAction.copy:
            return message.type == MessageType.text.index + 1;

          case ReviewAction.edit:
            return message.type == MessageType.text.index + 1;

          case ReviewAction.delete:
            return true;
        }
      }).toList();
}
