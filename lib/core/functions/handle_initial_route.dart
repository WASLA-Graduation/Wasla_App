import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/extensions/service_role_extension.dart';
import 'package:wasla/core/functions/get_right_route.dart';
import 'package:wasla/core/utils/app_strings.dart';

String handleInitialRoute() {
  final bool? isVisited =
      SharedPreferencesHelper.get(key: AppStrings.onboardingVisited) as bool?;
  final bool? isSignedIn =
      SharedPreferencesHelper.get(key: AppStrings.isSingedIn) as bool?;

  if (isVisited == null) {
    return AppRoutes.onboardingScreen;
  } else {
    if (isSignedIn == null) {
      return AppRoutes.signInScreen;
    } else {
      final String? role =
          SharedPreferencesHelper.get(key: ApiKeys.role) as String?;

      return getRightRoute(role: ServiceRoleExtension.fromString(role!));
    }
  }
}
