import 'package:wasla/features/payment/data/models/base_payment_model.dart';

class ResidentPaymentModel extends BasePaymentModel {
  final String residentName;

  ResidentPaymentModel({
    required this.residentName,
    required super.entityId,
    required super.totalAmount,
    required super.paymentDate,
    required super.paymentMethod,
    required super.status,
    required super.serviceType,
    required super.entityType,
  });

  factory ResidentPaymentModel.fromJson(Map<String, dynamic> json) {
    return ResidentPaymentModel(
      residentName: json['residentName'] ?? '',
      entityId: json['entityId'] ?? 0,
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate']),
      paymentMethod: json['paymentMethod'] ?? 0,
      status: json['status'] ?? 0,
      serviceType: json['serviceType'] ?? 0,
      entityType: json['entityType'] ?? 0,
    );
  }
}