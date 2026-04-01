import 'package:wasla/core/database/api/api_keys.dart';

class ChatMessagesModel {
  final int chatId;
  final String senderId;
  final String receiverId;
  final MessagesPage messages;

  ChatMessagesModel({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.messages,
  });

  factory ChatMessagesModel.fromJson(Map<String, dynamic> json) {
    return ChatMessagesModel(
      chatId: json[ApiKeys.chatId],
      senderId: json[ApiKeys.senderId],
      receiverId: json[ApiKeys.receiverId],
      messages: MessagesPage.fromJson(json[ApiKeys.messages]),
    );
  }
}

class MessagesPage {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final List<MessageModel> data;

  MessagesPage({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.data,
  });

  factory MessagesPage.fromJson(Map<String, dynamic> json) {
    return MessagesPage(
      pageNumber: json[ApiKeys.pageNumber],
      pageSize: json[ApiKeys.pageSize],
      totalCount: json[ApiKeys.totalCount],
      data: (json[ApiKeys.data] as List)
          .map((e) => MessageModel.fromJson(e))
          .toList(),
    );
  }
}

class MessageModel {
  String? messageText;
  String receiverId;
  String senderId;
  String? audio;
  int messageId;
  bool isMine;
  int type;
  DateTime sentAt;
  DateTime? readAt;
  bool isEdited;
  List<String> files;

  MessageModel({
    required this.messageText,
    required this.receiverId,
    required this.senderId,
    required this.audio,
    required this.messageId,
    required this.isMine,
    required this.type,
    required this.sentAt,
    required this.readAt,
    required this.isEdited,
    required this.files,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageText: json[ApiKeys.messageText],
      receiverId: json[ApiKeys.receiverId],
      senderId: json[ApiKeys.senderId],
      audio: json[ApiKeys.audio],
      messageId: json[ApiKeys.messageId],
      isMine: json[ApiKeys.isMine],
      type: json[ApiKeys.type],
      sentAt: DateTime.parse(json['sentAt']),
      readAt: json[ApiKeys.readAt] == null
          ? null
          : DateTime.parse(json[ApiKeys.readAt]),
      isEdited: json[ApiKeys.isEdited],
      files: List<String>.from(json[ApiKeys.files] ?? []),
    );
  }
}
