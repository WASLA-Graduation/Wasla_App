import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/service_role_extension.dart';

class SignInDataModel {
  final String token;
  final String userId;
  final ServiceRole role;
  final String refreshToken;
  final bool isVerified;
  final bool isCompleteRegister;
  final int statue;

  SignInDataModel({
    required this.isCompleteRegister,
    required this.isVerified,
    required this.statue,
    required this.token,
    required this.userId,
    required this.role,
    required this.refreshToken,
  });

  factory SignInDataModel.fromJson(Map<String, dynamic> json) {
    return SignInDataModel(
      token: json[ApiKeys.data][ApiKeys.token] ?? '',
      userId: json[ApiKeys.data][ApiKeys.userId] ?? '',
      role: ServiceRoleExtension.fromString(
        json[ApiKeys.data][ApiKeys.role] ?? 'resident',
      ),
      refreshToken: json[ApiKeys.data][ApiKeys.refreshToken] ?? '',
      isCompleteRegister: json[ApiKeys.data][ApiKeys.isCompletedRegister],
      isVerified: json[ApiKeys.data][ApiKeys.isVerfied],
      statue: json[ApiKeys.data][ApiKeys.statue],
    );
  }
}
