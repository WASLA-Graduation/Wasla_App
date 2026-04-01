import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/widgets/can_pop_widget.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

import 'package:wasla/features/auth/presentation/widgets/sign_up_body.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  void initState() {
    getRoles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 5),
        child: CanPopScreen(child: SignUpBody()),
      ),
    );
  }

  void getRoles() => context.read<AuthCubit>().getRoles();
}
