abstract class ApiEndPoints {
  static const String baseUrl = 'https://waslammka.runasp.net/';
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
  static const String residentGetProfile = 'api/Resident/get-Profile';
  static const String imageBaseUrl = '${baseUrl}assets/images/user/';
  static const String residentEditProfile = 'api/Resident/edit-Profile';
  static const String doctorGetProfile = 'api/Doctor/GetDoctorProfile/';
  static const String doctorGetServices = 'api/Service/GetServices/';
  static const String doctorUpdateService = 'api/Service/UpdateService';
  static const String doctorAddService = 'api/Service/AddService';
  static const String doctorDeleteService = 'api/Service/DeleteService/';
  static const String getDoctorBySpecialist =
      'api/Doctor/GetDoctorBySpecialist/';
  static const String doctorBookService = 'api/Book/BookService';
  static const String doctorUpdateProfile = 'api/Doctor/UpdateDoctorProfile';
  static const String doctorGetChart = 'api/Doctor/GetDoctorChart/';
  static const String doctorGetAllBooking =
      'api/Doctor/GetAllBookingsOfDoctor/';
  static const String updateBooking = 'api/Book/UpdateBooking';
  static const String updateBookingStatus = 'api/Book/UpdateBookingStatus';
  static const String getBookingDetailsForUser =
      'api/Book/GetBookingDetailsForUser';
  static const String getReviews = 'api/Review/service-provider/';
  static const String getReviewsByRating = 'api/Review/rating/';
  static const String addReview = 'api/Review/AddReview';
  static const String updateReview = 'api/Review/UpdateReview';
  static const String addToFavourite = 'api/Favourite/AddFavourite';
  static const String removeFromFavourite = 'api/Favourite/RemoveFavourite';
  static const String getAllFavourites = 'api/Favourite/RemoveFavourite';
  static const String getFavouritesByType = 'api/Favourite/GetFavouritesByType';
}
