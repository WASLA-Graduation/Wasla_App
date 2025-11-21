import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/profile_image_widget.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_show_Bottom_sheet_image.dart';
import 'package:wasla/features/profile/presentation/widgets/custom_profile_appbar.dart';
import 'package:wasla/features/profile/presentation/widgets/profile_list.dart';
import 'package:wasla/features/profile/presentation/widgets/user_name_email_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: CustomProfileAppbar()),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: ProfileImageWidget(
              onTap: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      ShowResidentBottomSheetImage(cubit: cubit),
                );
              },
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTktNmey-marKhm3jOKUfA1Ode3dO_9AHww4g&s",
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverToBoxAdapter(child: UserNameAndEmailWidget()),
          ProfileList(),
          SliverToBoxAdapter(
            child: _buildLogoutWidget(context),
          ),
        ],
      ),
    );
  }

  Row _buildLogoutWidget(BuildContext context) {
    return Row(
            children: [
              Image.asset(
          Assets.assetsImagesLogout,
          height: 24,
          width: 24,
          color: Colors.red,
        ),
        const SizedBox(width: 16),
        Text(
          "Logout",
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
            ],
          );
  }
}
