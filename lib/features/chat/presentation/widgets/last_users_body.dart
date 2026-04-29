import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
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
          current is ChatGetChatsOfUserSuccess ||
          current is ChatGetAllChatsOfUserLoadig ||
          current is ChatDeleteChat,
      builder: (context, state) {
        if (state is ChatGetAllChatsOfUserLoadig ||
            state is ChatInitial ||
            state is ChatOnRetryState) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is ChatGetChatsOfUserSuccess) {
          usersChats = state.allChats;
        }

        return usersChats.isEmpty
            ? EmptyStateWidget(
                title: 'noChats'.tr(context),
                message: 'noChatsDesc'.tr(context),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.marginDefault,
                ),
                child: LastUsersChatList(usersChat: usersChats),
              );
      },
    );
  }
}
