import 'package:wasla/features/chat/data/models/real_time_msg_model.dart';

class UsersChatMsgModel {
  String receiverId;
  String senderId;
  int chatId;
  String name;
  String profileReceiver;
  String messageText;
  int messageId;
  bool isMine;
  String? audio;
  bool isEdit;
  int type;
  List<dynamic> files;
  DateTime sentAt;
  DateTime? readAt;
  int unreadMessageCount;
  bool isTyping = false;

  UsersChatMsgModel({
    required this.unreadMessageCount,
    required this.receiverId,
    required this.senderId,
    required this.chatId,
    required this.name,
    required this.profileReceiver,
    required this.messageText,
    required this.messageId,
    required this.isMine,
    required this.audio,
    required this.isEdit,
    required this.type,
    required this.files,
    required this.sentAt,
    required this.readAt,
  });

  factory UsersChatMsgModel.fromJson(Map<String, dynamic> json) {
    return UsersChatMsgModel(
      receiverId: json['receiverId'] ?? '',
      unreadMessageCount: json['unreadMessageCount'] ?? 0,
      senderId: json['senderId'] ?? '',
      chatId: json['chatId'] ?? 0,
      name: json['name'] ?? '',
      profileReceiver: json['profileReceiver'] ?? '',
      messageText: json['messageText'] ?? '',
      messageId: json['messageId'] ?? 0,
      isMine: json['isMine'] ?? false,
      audio: json['audio'],
      isEdit: json['isEdit'] ?? false,
      type: json['type'] ?? 0,
      files: json['files'] ?? [],
      sentAt: DateTime.parse(json['sentAt']),
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
    );
  }

  factory UsersChatMsgModel.fromMap(
    RealTimeMsgModel realTimeModel,
    int count,
    bool isMe,
  ) {
    return UsersChatMsgModel(
      receiverId: realTimeModel.receiverId,
      unreadMessageCount: count,
      senderId: realTimeModel.senderId,
      chatId: realTimeModel.chatId,
      name: isMe
          ? realTimeModel.nameReceiver ?? ''
          : realTimeModel.nameSender ?? '',
      profileReceiver: isMe
          ? realTimeModel.profileReceiver ?? ''
          : realTimeModel.profileSender ?? '',
      messageText: realTimeModel.messageText ?? '',
      messageId: realTimeModel.id,
      isMine: isMe,
      audio: realTimeModel.audio,
      isEdit: realTimeModel.isEdited,
      type: realTimeModel.type,
      files: realTimeModel.files,
      sentAt: realTimeModel.sentAt,
      readAt: realTimeModel.readAt,
    );
  }
}
