import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/service/signalR/chat_hub.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/last_users_body.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_doc_add_service_float_button.dart';

class LastUsersViwe extends StatefulWidget {
  const LastUsersViwe({super.key});

  @override
  State<LastUsersViwe> createState() => _LastUsersViweState();
}

class _LastUsersViweState extends State<LastUsersViwe> {
  ChatHub chatHub = ChatHub();
  @override
  void initState() {
    getAllChats();
    super.initState();
    chatHub.init();
  }

  @override
  void dispose() {
    chatHub.disconnect();
    super.dispose();
  }

  bool isSearing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearing ? fillterdAppBar(context) : normalAppBar(context),
      floatingActionButton: CustomFloatingAddButton(
        onPressed: () {
          context.pushScreen(AppRoutes.allUsersChatssScreen);
        },
      ),

      body: BlocStatusHandler<ChatCubit, ChatState>(
        body: const LastUsersBody(),
        onRetry: () {
          getAllChats();
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
      title: Row(
        children: [
          Image.asset(Assets.assetsImagesWaslaLogo, width: 30, height: 30),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              onChanged: (value) => context
                  .read<ChatCubit>()
                  .searchForUsersThatHaveChatWithTheme(query: value),
              controller: context.read<ChatCubit>().searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "searchForChat".tr(context),
                hintStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearing = !isSearing;
              context.read<ChatCubit>().searchController.clear();
            });
            context.read<ChatCubit>().whenUserChatsSearchCancelled();
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
      title: Row(
        children: [
          Image.asset(Assets.assetsImagesWaslaLogo, width: 30, height: 30),
          const SizedBox(width: 10),
          Text("inbox".tr(context)),
        ],
      ),
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

  void getAllChats() {
    final cubit = context.read<ChatCubit>();
    cubit.getCurrentUser();
    cubit.allChatsOfUserEndOfPagination = false;
    cubit.allChatsOfUserPageNumber = 1;
    cubit.allChatsOfUser = [];
    cubit.getAllChatsOfUser(fromPagination: false);
  }
}
