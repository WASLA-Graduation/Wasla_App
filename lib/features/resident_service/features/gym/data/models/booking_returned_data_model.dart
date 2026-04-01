import 'package:wasla/core/database/api/api_keys.dart';

class BookingReturnedDataModel {
  // final String qrCodeUrl;
  final int bookingId;

  BookingReturnedDataModel(
    this.bookingId,

    // {required this.qrCodeUrl}
  );
  factory BookingReturnedDataModel.fromJson(Map<String, dynamic> json) {
    return BookingReturnedDataModel(
      json[ApiKeys.bookingId],
      // qrCodeUrl: ApiEndPoints.qrBaseUrl + json[ApiKeys.qrCodeUrl],
    );
  }
}
