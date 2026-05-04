abstract class BasePaymentModel {
  final int entityId;
  final double totalAmount;
  final DateTime paymentDate;
  final int paymentMethod;
  final int status;
  final int serviceType;
  final int entityType;

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