import 'package:wasla/core/database/api/api_keys.dart';

class BookingHubModel {
  final int serviceId;
  final String serviceProviderId;
  final String residentId;

  const BookingHubModel({
    required this.serviceId,
    required this.serviceProviderId,
    required this.residentId,
  });

  factory BookingHubModel.fromJson(Map<String, dynamic> json) {
    return BookingHubModel(
      serviceId: json[ApiKeys.serviceId] as int,
      serviceProviderId: json[ApiKeys.serviceProviderId] as String,
      residentId: json[ApiKeys.residentId] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.serviceId: serviceId,
      ApiKeys.serviceProviderId: serviceProviderId,
      ApiKeys.residentId: residentId,
    };
  }
}
