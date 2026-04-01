import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_resturent_form_info.dart';


class ResturentInfoBody extends StatelessWidget {
  const ResturentInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return CustomResturentInfo(cubit: cubit);
        },
      ),
    );
  }
}

