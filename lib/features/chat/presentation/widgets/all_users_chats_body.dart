import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/chat/data/models/all_users_chat_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/all_user_chats_list.dart';

class AllUsersChatsBody extends StatefulWidget {
  const AllUsersChatsBody({super.key});

  @override
  State<AllUsersChatsBody> createState() => _AllUsersChatsBodyState();
}

class _AllUsersChatsBodyState extends State<AllUsersChatsBody> {
  List<AllUsersChatModel> users = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          current is ChatGetAllUsersSuccess || current is ChatGetAllUsersLoadig,
      builder: (context, state) {
        if (state is ChatGetAllUsersLoadig || state is ChatOnRetryState) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is ChatGetAllUsersSuccess) {
          users = state.allUsers;
        }
        if (users.isEmpty) {
          return EmptyStateWidget(
            title: 'noUsers'.tr(context),
            message: 'noUsersDesc'.tr(context),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
          child: AllUsersChatList(users: users),
        );
      },
    );
  }
}
