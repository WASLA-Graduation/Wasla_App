import 'package:wasla/core/database/api/api_keys.dart';

class BookingReturnedDataModel {
   int bookingId;

  BookingReturnedDataModel(
    this.bookingId,

  );
  factory BookingReturnedDataModel.fromJson(Map<String, dynamic> json) {
    return BookingReturnedDataModel(
      json[ApiKeys.bookingId],
    );
  }
}
