import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:wasla/features/chat/data/models/all_users_chat_model.dart';
import 'package:wasla/features/chat/data/models/chat_user_info.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/data/models/users_chat_msg_model.dart';

abstract class ChatRepo {
  Future<Either<String, Null>> sendMsg({
    required String senderId,
    required String receiverId,
    required int type,
    String? messageText,
    File? audio,
    List<File>? images,
  });
  Future<Either<String, Null>> updateMsg({
    required String senderId,
    required String messageText,
    required int messageId,
    required int type,
    required List<String> existFiles,
  });

  Future<Either<String, Null>> deleteMsg({
    required int messageId,
    required String senderId,
  });

  Future<Either<String, Null>> editUserBio({
    required String userId,
    required String bio,
  });
  Future<Either<String, Null>> deleteChat({
    required int chatId,
    required String userId,
  });
  Future<Either<String, ChatMessagesModel>> getUserChat({
    required String senderId,
    required String receiverId,
    required int pageNumber,
    required int pageSize,
  });
  Future<Either<String, List<AllUsersChatModel>>> getAllUsers({
    required int pageNumber,
    required int pageSize,
  });
  Future<Either<String, List<AllUsersChatModel>>> searchForUsers({
    required String word,
  });
  Future<Either<String, List<UsersChatMsgModel>>>
  getUsersThatHaveChatWithTheme({
    required int pageNumber,
    required int pageSize,
    required String userId,
  });

  Future<Either<String, List<UsersChatMsgModel>>>
  searchForUsersThatHaveChatWithTheme({required String word});
  Future<Either<String, ChatUserInfo>> getChatUserInfo({
    required String userId,
  });
  Future<Either<String, Null>> readMsgs({required String chatId});
}
