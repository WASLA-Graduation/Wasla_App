import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
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
          current is ChatGetAllUsersFailure ||
          current is ChatGetAllUsersSuccess ||
          current is ChatGetAllUsersLoadig,
      builder: (context, state) {
        if (state is ChatGetAllUsersFailure) {
          return CustomErrGetData();
        } else if (state is ChatGetAllUsersLoadig) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          if (state is ChatGetAllUsersSuccess) {
            users = state.allUsers;
          }
          if (users.isEmpty) {
            return Center(
              child: Text(
                "noUsers".tr(context),
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return AllUsersChatList(users: users);
        }
      },
    );
  }
}
