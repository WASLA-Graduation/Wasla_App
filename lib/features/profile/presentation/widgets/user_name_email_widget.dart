import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class UserNameAndEmailWidget extends StatelessWidget {
  const UserNameAndEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Center(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: state is ProfileGetProfileLoading
                    ? _buildTextLoading(context)
                    : Text(
                        cubit.user!.fullName,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
              ),
              const SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.scaleDown,

                child:state is ProfileGetProfileLoading
                    ? _buildTextLoading(context)
                    : Text(
                  cubit.user!.email,
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(color: AppColors.gray),
                ),
              ),
              const Divider(height: 40, thickness: 0.3),
            ],
          );
        },
      ),
    );
  }

  Skeletonizer _buildTextLoading(BuildContext context) {
    return Skeletonizer(
                      child: Text(
                        "Mostafa Salah",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
  }
}
