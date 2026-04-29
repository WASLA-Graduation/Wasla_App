import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/service/Audio/audio_service.dart';
import 'package:wasla/core/service/Audio/record_service.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/error_widget.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_footer.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_msg_list.dart';

class ChatBody extends StatefulWidget {
  final String recieverId;
  const ChatBody({super.key, required this.recieverId});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  List<MessageModel> messages = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ChatCubit, ChatState>(
          buildWhen: (previous, current) =>
              current is ChatGetCahtFailure ||
              current is ChatGetCahtOfUserSuccess ||
              current is ChatGetCahtOfUserLoadig ||
              current is ChatDeleteMsg ||
              current is ChatReadMsgs,
          builder: (context, state) {
            if (state is ChatGetCahtFailure) {
              return Expanded(
                child: MyErrorWidget(
                  onRetry: () {
                    context.read<ChatCubit>().getChat(
                      fromPagination: false,
                      recieverId: widget.recieverId,
                    );
                  },
                ),
              );
            } else if (state is ChatGetCahtOfUserLoadig) {
              return Expanded(
                child: Center(
                  child: SpinKitFadingCircle(
                    color: AppColors.primaryColor,
                    size: 50.0,
                  ),
                ),
              );
            } else {
              if (state is ChatGetCahtOfUserSuccess) {
                if (state.messages.isNotEmpty) {
                  messages = state.messages;
                }
              }
              if (messages.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      "sayHello".tr(context),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }

              return ChatMsgList(
                messages: messages,
                recieverId: widget.recieverId,
              );
            }
          },
        ),

        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => RecordService()),
            RepositoryProvider(create: (context) => AudioService()),
          ],
          child: ChatFooter(),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

// Expanded(child: ChatMsgList()),
