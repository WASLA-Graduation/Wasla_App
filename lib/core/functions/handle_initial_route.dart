import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';

String handleInitialRoute() {
  final bool? isVisited =
      SharedPreferencesHelper.get(key: 'onboardingVisited') as bool?;

  if (isVisited == null) {
    return AppRoutes.onboardingScreen;
  } else {
    return AppRoutes.signInScreen;
  }
}
