import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/features/profile/data/models/profile_item_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/custom_switch_button.dart';
import 'package:wasla/features/profile/presentation/widgets/profile_item.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: ProfileItemModel.items.length,

      itemBuilder: (context, index) => InkWell(
        onTap: () {
          if (index == 0) {
            context.pushScreen(
              ProfileItemModel.items[index].route,
              arguments: context.read<ProfileCubit>().user,
            );
          } else {
            context.pushScreen(ProfileItemModel.items[index].route);
          }
        },
        child: ProfileItem(
          profileItemModel: ProfileItemModel.items[index],
          trailing: index == 4
              ? CustomSwitchButton(
                  onChanged: (value) {
                    context.read<GlobalCubit>().changeTheme(
                      themeMode: value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                  value: context.isDarkMode,
                )
              : null,
        ),
      ),
    );
  }
}
