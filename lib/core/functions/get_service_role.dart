import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/service_role_extension.dart';

ServiceRole getServiceRole() {
  final String? role =
      SharedPreferencesHelper.get(key: ApiKeys.role) as String?;

  return ServiceRoleExtension.fromString(role!);
}
