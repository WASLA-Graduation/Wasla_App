import 'package:wasla/core/enums/service_role.dart';

extension ServiceRoleExtension on ServiceRole {
  String get stringValue => name;

  static ServiceRole fromString(String value) {
    return ServiceRole.values.firstWhere((e) => e.name == value);
  }
}
