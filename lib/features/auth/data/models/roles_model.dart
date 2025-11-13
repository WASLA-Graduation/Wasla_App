import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/service_role_extension.dart';

class RolesModel {
  final String id, roleName;
  final ServiceRole serviceRole;

  RolesModel({
    required this.id,
    required this.roleName,
    required this.serviceRole,
  });

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      id: json[ApiKeys.id],
      roleName: json[ApiKeys.roleName],
      serviceRole: ServiceRoleExtension.fromString(json[ApiKeys.value]),
    );
  }
}
