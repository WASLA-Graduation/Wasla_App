import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/chat/data/models/all_users_chat_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';

class AllUsersChatList extends StatelessWidget {
  const AllUsersChatList({super.key, required this.users});
  final List<AllUsersChatModel> users;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: () {
        context.read<ChatCubit>().getAllUsers(fromPagination: true);
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              padding: EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.pushScreen(
                    AppRoutes.chatScreen,
                    arguments: {
                      AppStrings.id: users[index].id,
                      AppStrings.name: users[index].name,
                      AppStrings.photo: users[index].image,
                    },
                  );
                },
                child: AllUsersChatItem(user: users.elementAt(index)),
              ),
            ),
          ),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return state is ChatGetAllUsersLoadigFromPagination
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

class AllUsersChatItem extends StatelessWidget {
  const AllUsersChatItem({super.key, required this.user});
  final AllUsersChatModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleNeworkImage(
        size: 53,
        imageUrl: user.image,
        isLoading: false,
      ),

      title: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        user.name,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        user.bio,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
