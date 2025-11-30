import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/views/doctor_add_service_view.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/views/doctor_booking_view.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/views/doctor_review_view.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/views/doctor_see_serevices_view.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';
import 'package:wasla/core/service/maps/cubit/maps_helper_cubit.dart';
import 'package:wasla/features/auth/presentation/views/auth_map_view.dart';
import 'package:wasla/features/auth/presentation/views/choose_auth_view.dart';
import 'package:wasla/features/auth/presentation/views/doctor_complete_info_view.dart';
import 'package:wasla/features/auth/presentation/views/doctor_info_view.dart';
import 'package:wasla/features/auth/presentation/views/forgot_pass_view.dart';
import 'package:wasla/features/auth/presentation/views/reset_pass_view.dart';
import 'package:wasla/features/auth/presentation/views/resident_info_view.dart';
import 'package:wasla/features/auth/presentation/views/resurent_info_view.dart';
import 'package:wasla/features/auth/presentation/views/sign_in_view.dart';
import 'package:wasla/features/auth/presentation/views/sign_up_view.dart';
import 'package:wasla/features/auth/presentation/views/verification_code_view.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/views/doctor_nav_bar_view.dart';
import 'package:wasla/features/onboarding/presentation/manager/cubit/onboarding_cubit.dart';
import 'package:wasla/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:wasla/features/profile/presentation/views/account_change_pass_view.dart';
import 'package:wasla/features/profile/presentation/views/change_lang_view.dart';
import 'package:wasla/features/profile/presentation/views/resident_edit_profile_view.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/views/doctor_details_view.dart';
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
      case AppRoutes.resturentInfoScreen:
        return MaterialPageRoute(builder: (_) => ResurentInfoView());

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
      case AppRoutes.doctorDetailsScreen:
        final DoctorDataModel doc = settigns.arguments as DoctorDataModel;
        return MaterialPageRoute(
          builder: (_) => DoctorDetailsView(doctor: doc),
        );
      case AppRoutes.chnageLangScreen:
        return MaterialPageRoute(builder: (_) => ChangeLangView());
      case AppRoutes.residentEditProfileScreen:
        final UserModel userModel = settigns.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => ResidentEditProfileView(user: userModel),
        );
      case AppRoutes.accountChangePassScreen:
        return MaterialPageRoute(builder: (_) => AccountChangePassView());
      case AppRoutes.doctorNavbarScreen:
        return MaterialPageRoute(builder: (_) => DoctorNavBarView());
      case AppRoutes.doctorAddServiceScreen:
        return MaterialPageRoute(builder: (_) => DoctorAddServiceView());
      case AppRoutes.doctorReviewScreen:
        return MaterialPageRoute(builder: (_) => DoctorReviewView());
      case AppRoutes.doctorSeeSevicesScreen:
        final String doctorId = settigns.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DoctorSeeSerevicesView(docId: doctorId),
        );
      case AppRoutes.doctorBookingScreen:
        final DoctorServiceModel doctorServiceModel =
            settigns.arguments as DoctorServiceModel;
        return MaterialPageRoute(
          builder: (_) =>
              DoctorBookingView(doctorServiceModel: doctorServiceModel),
        );

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
