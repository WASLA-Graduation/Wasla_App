import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/enums/service_provider_type.dart';
import 'package:wasla/features/payment/data/models/base_payment_model.dart';

class ServiceProviderPaymentModel extends BasePaymentModel {
  final String serviceProviderName;

  ServiceProviderPaymentModel({
    required this.serviceProviderName,
    required super.entityId,
    required super.totalAmount,
    required super.paymentDate,
    required super.paymentMethod,
    required super.status,
    required super.serviceType,
    required super.entityType,
  });

  factory ServiceProviderPaymentModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderPaymentModel(
      serviceProviderName: json['serviceProviderName'] ?? '',
      entityId: json['entityId'] ?? 0,
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate']),
      paymentMethod: PaymentMethod.values[json['paymentMethod'] -1 ?? 0],
      status: PaymentStatus.values[json['status'] ?? 0],
      serviceType: ServiceProviderTypeEnum.values[json['serviceType'] - 1 ?? 0],
      entityType: EntityType.values[json['entityType'] ?? 0],
    );
  }
}
