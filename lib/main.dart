import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:wasla/app/wasla_app.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/core/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.lightbackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await SharedPreferencesHelper.init();
  initializeServiceLocator();

  runApp(WaslaApp());
}
