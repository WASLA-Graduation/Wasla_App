abstract class ApiEndPoints {
  static const String baseUrl = 'http://wasla1.runasp.net/';
  static const String register = 'api/Account/register';
  static const String login = 'api/Account/login';
  static const String resetPasswordForProfile = 'api/Account/change-password';
  static const String forgotPassCheckEmail =
      'api/Account/check-mail-verification';
  static const String verifyEmail = 'api/Account/verify-email';
  static const String forgotPass = 'api/Account/forget-password';
  static const String getRols = 'api/Roles';
  static const String doctorCompleteInfo = 'api/Doctor/CompleteData';
  static const String getDoctorSpecializations =
      'api/Doctor/DoctorSpecializations';
  static const String residentCompleteRegister =
      'api/Resident/CompleteRegister';
  static const String residentGetProfile = 'api/Account/get-Profile';
  static const String imageBaseUrl =
      'http://wasla1.runasp.net/assets/images/user/';
  static const String residentEditProfile = 'api/Account/edit-Profile';
}
