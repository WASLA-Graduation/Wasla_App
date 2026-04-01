import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/chat/data/models/users_chat_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/last_users_chat_item.dart';

class LastUsersChatList extends StatelessWidget {
  const LastUsersChatList({super.key, required this.usersChat});
  final List<UsersChatMsgModel> usersChat;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return PaginationListener(
      onLoadMore: () {
        context.read<ChatCubit>().getAllChatsOfUser(fromPagination: true);
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              padding: EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: usersChat.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  final bool isMe =
                      cubit.currentUser == usersChat[index].senderId;
                  cubit.currentChatId = usersChat[index].chatId.toString();
                  context.pushScreen(
                    AppRoutes.chatScreen,
                    arguments: {
                      AppStrings.id: isMe
                          ? usersChat[index].receiverId
                          : usersChat[index].senderId,
                      AppStrings.name: usersChat[index].name,
                      AppStrings.photo: usersChat[index].profileReceiver,
                    },
                  );
                },
                child: LastUsersChatItem(userChat: usersChat[index]),
              ),
            ),
          ),

          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return state is ChatGetChatsOfUserLoadigFromPagination
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
