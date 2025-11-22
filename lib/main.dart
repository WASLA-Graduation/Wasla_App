import 'package:flutter/cupertino.dart';
import 'package:wasla/app/wasla_app.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/service/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  initializeServiceLocator();
  runApp(WaslaApp());
}
