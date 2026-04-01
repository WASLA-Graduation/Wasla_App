part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatPickImages extends ChatState {}
final class ChatSearchState extends ChatState {}
final class ChatRecorded extends ChatState {}
final class ChatRecordChangePosition extends ChatState {}

final class ChatWhenUserTyping extends ChatState {}

final class ChatAddMsgState extends ChatState {}

final class ChatGetAllUsersLoadig extends ChatState {}

final class ChatGetAllUsersLoadigFromPagination extends ChatState {}

final class ChatDeleteMsg extends ChatState {}

final class ChatDeleteChat extends ChatState {}

final class ChatUpdateMsg extends ChatState {}
final class ChatReadMsgs extends ChatState {}

final class ChatGetAllUsersSuccess extends ChatState {
  final List<AllUsersChatModel> allUsers;

  ChatGetAllUsersSuccess({required this.allUsers});
}

final class ChatGetAllUsersFailure extends ChatState {
  final String errorMessage;
  ChatGetAllUsersFailure({required this.errorMessage});
}

final class ChatGetChatsOfUserLoadigFromPagination extends ChatState {}

final class ChatGetAllChatsOfUserLoadig extends ChatState {}

final class ChatGetChatsOfUserSuccess extends ChatState {
  final List<UsersChatMsgModel> allChats;

  ChatGetChatsOfUserSuccess({required this.allChats});
}

final class ChatGetChatsOfUserFailure extends ChatState {
  final String errorMessage;
  ChatGetChatsOfUserFailure({required this.errorMessage});
}

final class ChatGetCahtLoadigFromPagination extends ChatState {}

final class ChatGetCahtOfUserLoadig extends ChatState {}

final class ChatGetCahtOfUserSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatGetCahtOfUserSuccess({required this.messages});
}

final class ChatGetCahtFailure extends ChatState {
  final String errorMessage;
  ChatGetCahtFailure({required this.errorMessage});
}


final class ChatGetUserInfo extends ChatState {}

