import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/views/choose_auth_view.dart';
import 'package:wasla/features/auth/presentation/views/choose_service_view.dart';
import 'package:wasla/features/auth/presentation/views/forgot_pass_view.dart';
import 'package:wasla/features/auth/presentation/views/reset_pass_view.dart';
import 'package:wasla/features/auth/presentation/views/resident_info_view.dart';
import 'package:wasla/features/auth/presentation/views/sign_in_view.dart';
import 'package:wasla/features/auth/presentation/views/sign_up_view.dart';
import 'package:wasla/features/auth/presentation/views/verification_code_view.dart';
import 'package:wasla/features/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:wasla/features/onboarding/presentation/views/onboarding_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settigns) {
    switch (settigns.name) {
      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OnboardingCubit(),
            child: const OnboardingView(),
          ),
        );

      case AppRoutes.chooseServiceScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: ChooseServiceView(),
          ),
        );
      case AppRoutes.chooseAuthScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: ChooseAuthView(),
          ),
        );
      case AppRoutes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: SignInView(),
          ),
        );
      case AppRoutes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: SignUpView(),
          ),
        );
      case AppRoutes.resetPassScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: ResetPassView(),
          ),
        );
      case AppRoutes.forgotScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: ForgotPassView(),
          ),
        );

      case AppRoutes.verifyScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit()..resendCodeTimer(),
            child: VerificationCodeView(),
          ),
        );
      case AppRoutes.residentInfoScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: ResidentInfoView(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
