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
  static const String gymBaseUrl = '${baseUrl}assets/images/gym/';
  static const String doctorBaseUrl = '${baseUrl}assets/images/doctor/';
  static const String qrBaseUrl = '${baseUrl}assets/qrcodes/';
  static const String fileBaseUrl = '${baseUrl}assets/cv/doctor/';
  static const String residentEditProfile = 'api/Resident/edit-Profile';
  static const String doctorGetProfile = 'api/Doctor/GetDoctorProfile/';
  static const String doctorGetServices = 'api/DoctorService/GetServices/';
  static const String doctorUpdateService = 'api/DoctorService/UpdateService';
  static const String doctorAddService = 'api/DoctorService/AddService';
  static const String doctorDeleteService = 'api/DoctorService/DeleteService/';
  static const String getDoctorBySpecialist =
      'api/Doctor/GetDoctorBySpecialist/';
  static const String doctorBookService = 'api/DoctorBook/BookService';
  static const String doctorUpdateProfile = 'api/Doctor/UpdateDoctorProfile';
  static const String doctorGetChart = 'api/Doctor/GetDoctorChart/';
  static const String doctorGetAllBooking =
      'api/Doctor/GetAllBookingsOfDoctor/';
  static const String updateBooking = 'api/DoctorBook/UpdateBooking';
  static const String updateBookingStatus =
      'api/DoctorBook/UpdateBookingStatus';
  static const String getBookingDetailsForUser =
      'api/DoctorBook/GetBookingDetailsForUser';
  static const String getReviews = 'api/Review/service-provider/';
  static const String getReviewsByRating = 'api/Review/ratings/';
  static const String addReview = 'api/Review/AddReview';
  static const String updateReview = 'api/Review/UpdateReview';
  static const String removeReview = 'api/Review/rating/';
  static const String addToFavourite = 'api/Favourite/AddFavourite';
  static const String removeFromFavourite = 'api/Favourite/RemoveFavourite';
  static const String getAllFavourites = 'api/Favourite/GetAllFavourites';
  static const String getFavouritesByType = 'api/Favourite/GetFavouritesByType';
  static const String refreshToken = 'api/Account/refresh-token';
  static const String logout = 'api/Account/logout';
  static const String getDoctorById = 'api/Doctor/GetDoctorData/';
  static const String gymCompleteRegister = 'api/Gym/CompleteRegister';
  static const String getAllGyms = 'api/Gym/AllGyms';
  static const String getGymProfile = 'api/Gym/GymProfile';
  static const String getGymUpdateProfile = 'api/Gym/UpdateProfile';
  static const String gymPackage = 'api/Package';
  static const String getGymCharts = 'api/GymBooking/Charts/';
  static const String getGymAllBookings = 'api/GymBooking/gym/';
  static const String gymCancelBooking = 'api/GymBooking/cancel/';
  static const String bookAtGym = 'api/GymBooking/book';

}
