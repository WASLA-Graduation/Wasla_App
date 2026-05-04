import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/enums/service_provider_type.dart';
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
      paymentMethod: PaymentMethod.values[json['paymentMethod'] - 1 ?? 0],
      status: PaymentStatus.values[json['status'] ?? 0],
      serviceType: ServiceProviderTypeEnum.values[json['serviceType'] ?? 0],
      entityType: EntityType.values[json['entityType'] ?? 0],
    );
  }
}
