import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/custom_profile_picture.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_show_Bottom_sheet_image.dart';

class TechnicantInfoImageWidget extends StatelessWidget {
  const TechnicantInfoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => current is AuthUpdateResidentImage,
      builder: (context, state) {
        return Center(
          child: CustomProfilePicture(
            image: cubit.residentImage,
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    ShowResidentBottomSheetImage(cubit: cubit),
              );
            },
          ),
        );
      },
    );
  }
}
