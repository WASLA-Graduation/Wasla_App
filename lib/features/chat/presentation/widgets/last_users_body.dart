import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/chat/data/models/users_chat_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/last_users_chat_list.dart';

class LastUsersBody extends StatefulWidget {
  const LastUsersBody({super.key});

  @override
  State<LastUsersBody> createState() => _LastUsersBodyState();
}

class _LastUsersBodyState extends State<LastUsersBody> {
  List<UsersChatMsgModel> usersChats = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          current is ChatGetChatsOfUserFailure ||
          current is ChatGetChatsOfUserSuccess ||
          current is ChatGetAllChatsOfUserLoadig ||
          current is ChatDeleteChat,
      builder: (context, state) {
        if (state is ChatGetChatsOfUserFailure) {
          return CustomErrGetData();
        } else if (state is ChatGetAllChatsOfUserLoadig) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          if (state is ChatGetChatsOfUserSuccess) {
            usersChats = state.allChats;
          }
          if (usersChats.isEmpty) {
            return Center(
              child: Text(
                "noChats".tr(context),
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return LastUsersChatList(usersChat: usersChats);
        }
      },
    );
  }
}
