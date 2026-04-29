import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/all_users_chats_body.dart';

class AllUsersChatsView extends StatefulWidget {
  const AllUsersChatsView({super.key});

  @override
  State<AllUsersChatsView> createState() => _AllUsersViewState();
}

class _AllUsersViewState extends State<AllUsersChatsView> {
  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  bool isSearing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearing ? fillterdAppBar(context) : normalAppBar(context),
      body: BlocStatusHandler<ChatCubit, ChatState>(
        body: const AllUsersChatsBody(),
        onRetry: () {
          getAllUsers();
          context.read<ChatCubit>().onRetry();
        },
        isNetwork: (state) => state is ChatNetworkState,
        isError: (state) => state is ChatFailureState,
        buildWhen: (previous, current) =>
            current is ChatNetworkState ||
            current is ChatFailureState ||
            current is ChatOnRetryState,
      ),
    );
  }

  PreferredSizeWidget fillterdAppBar(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: TextFormField(
        onChanged: (value) =>
            context.read<ChatCubit>().searchForAllUsers(query: value),
        controller: context.read<ChatCubit>().searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "searchForUser".tr(context),
          hintStyle: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearing = !isSearing;
              context.read<ChatCubit>().searchController.clear();
            });
            context.read<ChatCubit>().whenAllUsersSearchCancelled();
          },
          icon: Icon(
            Icons.clear,
            color: context.isDarkMode ? Colors.white : Colors.black,
            size: 25,
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget normalAppBar(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: Text('allUsers'.tr(context)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              setState(() {
                isSearing = !isSearing;
              });
            },
            icon: Icon(
              Icons.search,
              color: context.isDarkMode ? Colors.white : Colors.black,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  void getAllUsers() {
    final cubit = context.read<ChatCubit>();
    cubit.allUserEndOfPagination = false;
    cubit.allUsersPageNumber = 1;
    cubit.getAllUsers(fromPagination: false);
  }
}
