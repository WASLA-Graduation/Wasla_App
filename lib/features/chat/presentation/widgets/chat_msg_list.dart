import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_msg_item.dart';

class ChatMsgList extends StatefulWidget {
  const ChatMsgList({
    super.key,
    required this.messages,
    required this.recieverId,
  });
  final List<MessageModel> messages;
  final String recieverId;

  @override
  State<ChatMsgList> createState() => _ChatMsgListState();
}

class _ChatMsgListState extends State<ChatMsgList> {
  @override
  void initState() {
    readMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return state is ChatGetCahtLoadigFromPagination
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
          Expanded(
            child: PaginationListener(
              onLoadMore: () {
                context.read<ChatCubit>().getChat(
                  fromPagination: true,
                  recieverId: widget.recieverId,
                );
              },
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 30),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 25),
                physics: const BouncingScrollPhysics(),
                itemCount: widget.messages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return ChatMsgItem(message: widget.messages[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void readMessages() {
    final cubit = context.read<ChatCubit>();
    if (cubit.currentChatId.isNotEmpty) {
      cubit.readMsgs(chatId: cubit.currentChatId);
    }
  }
}
