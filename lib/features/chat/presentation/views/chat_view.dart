import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_body.dart';

class ChatView extends StatefulWidget {
  final Map<String, dynamic> data;
  const ChatView({super.key, required this.data});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    getChat();
    super.initState();
  }

  @override
  void deactivate() {
    context.read<ChatCubit>().currentChatId = '';
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(data: widget.data),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ChatBody(recieverId: widget.data[AppStrings.id]),
      ),
    );
  }

  void getChat() {
    final cubit = context.read<ChatCubit>();
    cubit.messages.clear();
    cubit.resetMsg();
    cubit.userInfo = null;
    cubit.chatPageNumber = 1;
    cubit.chatPageSize = 10;
    cubit.isEdit = false;
    cubit.editedMsg = null;
    cubit.chatEndOfPagination = false;
    cubit.getUserInfo(id: widget.data[AppStrings.id]);
    cubit.getChat(
      fromPagination: false,
      recieverId: widget.data[AppStrings.id],
    );
  }
}
