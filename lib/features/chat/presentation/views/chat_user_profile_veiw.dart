import 'package:flutter/material.dart';
import 'package:wasla/features/chat/data/models/chat_user_info.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_user_profile_body.dart';

class ChatUserProfileVeiw extends StatelessWidget {
  const ChatUserProfileVeiw({super.key, required this.user});

  final ChatUserInfo user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ChatUserProfileBody(user: user),
    );
  }
}
