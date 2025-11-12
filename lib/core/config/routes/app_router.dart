import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/service/maps/cubit/maps_helper_cubit.dart';
import 'package:wasla/features/auth/presentation/views/auth_map_view.dart';
import 'package:wasla/features/auth/presentation/views/choose_auth_view.dart';
import 'package:wasla/features/auth/presentation/views/doctor_complete_info_view.dart';
import 'package:wasla/features/auth/presentation/views/doctor_info_view.dart';
import 'package:wasla/features/auth/presentation/views/forgot_pass_view.dart';
import 'package:wasla/features/auth/presentation/views/reset_pass_view.dart';
import 'package:wasla/features/auth/presentation/views/resident_info_view.dart';
import 'package:wasla/features/auth/presentation/views/sign_in_view.dart';
import 'package:wasla/features/auth/presentation/views/sign_up_view.dart';
import 'package:wasla/features/auth/presentation/views/verification_code_view.dart';
import 'package:wasla/features/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:wasla/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/views/doctor_view.dart';
import 'package:wasla/features/resident_service/features/home/presentation/views/all_services_view.dart';
import 'package:wasla/features/resident_service/features/home/presentation/views/home_resident_navbar.dart';
import 'package:wasla/features/resident_service/features/home/presentation/views/resident_home_view.dart';
import 'package:wasla/features/resident_service/features/home/presentation/views/resident_search_viwe.dart';
import 'package:wasla/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settigns) {
    switch (settigns.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashView());
      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OnboardingCubit(),
            child: const OnboardingView(),
          ),
        );

      case AppRoutes.chooseAuthScreen:
        return MaterialPageRoute(builder: (_) => ChooseAuthView());
      case AppRoutes.signInScreen:
        return MaterialPageRoute(builder: (_) => SignInView());
      case AppRoutes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case AppRoutes.resetPassScreen:
        return MaterialPageRoute(builder: (_) => ResetPassView());
      case AppRoutes.forgotScreen:
        return MaterialPageRoute(builder: (_) => ForgotPassView());
      case AppRoutes.authMapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MapsHelperCubit()..getCurrentLocation(),
            child: AuthMapView(),
          ),
        );
      case AppRoutes.verifyScreen:
        final String nextRoute = settigns.arguments as String;
        return MaterialPageRoute(
          builder: (_) => VerificationCodeView(nextRoute: nextRoute),
        );
      case AppRoutes.residentInfoScreen:
        return MaterialPageRoute(builder: (_) => ResidentInfoView());
      case AppRoutes.doctorInfoScreen:
        return MaterialPageRoute(builder: (_) => DoctorInfoView());
      case AppRoutes.doctorCompleteInfoScreen:
        return MaterialPageRoute(builder: (_) => DoctorCompleteInfoView());

      case AppRoutes.residentHomeScreen:
        return MaterialPageRoute(builder: (_) => ResidentHomeView());
      case AppRoutes.residenBottomNavBar:
        return MaterialPageRoute(builder: (_) => HomeResidentNavbar());
      case AppRoutes.allServicesScreen:
        return MaterialPageRoute(builder: (_) => AllServicesView());
      case AppRoutes.residentSearchScreen:
        return MaterialPageRoute(builder: (_) => ResidentSearchViwe());
      case AppRoutes.doctorScreen:
        return MaterialPageRoute(builder: (_) => DoctorView());

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
