import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/verificatio_code_body.dart';

class VerificationCodeView extends StatefulWidget {
  final String nextRoute;
  const VerificationCodeView({super.key, required this.nextRoute});

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> {
  @override
  void initState() {
    resendCodeTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("verificationCode".tr(context))),
      body: VerificationCodeBody(nextRoute: widget.nextRoute),
    );
  }

  void resendCodeTimer() {
    context.read<AuthCubit>().resendCodeTimer();
  }
}
