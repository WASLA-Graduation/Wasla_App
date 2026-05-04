import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/enums/service_provider_type.dart';

abstract class BasePaymentModel {
  final int entityId;
  final double totalAmount;
  final DateTime paymentDate;
  final PaymentMethod paymentMethod;
  final PaymentStatus status;
  final ServiceProviderTypeEnum serviceType;
  final EntityType entityType;

  BasePaymentModel({
    required this.entityId,
    required this.totalAmount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.status,
    required this.serviceType,
    required this.entityType,
  });
}
