import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/features/restaurant/orders/data/model/base_order_model.dart';

class ResidentOrderModel extends BaseOrderModel {
  final String restaurantName;
  final int? paymobOrderId;

  ResidentOrderModel({
    required this.restaurantName,
    required this.paymobOrderId,
    required super.id,
    required super.totalPrice,
    required super.address,
    required super.notes,
    required super.deliveryFee,
    required super.paymentKey,
    required super.transactionId,
    required super.paymentStatus,
    required super.paymentMethod,
    required super.createdAt,
    required super.items,
    required super.status,
  });

  factory ResidentOrderModel.fromJson(Map<String, dynamic> json) {
    return ResidentOrderModel(
      restaurantName: json['restaurantName'],
      paymobOrderId: json['paymobOrderId'],
      status: OrderStatus.fromInt(json['status']),
      id: json['id'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      address: json['address'],
      notes: json['notes'] ?? '',
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      paymentKey: json['paymentKey'],
      transactionId: json['transactionId'],
      paymentStatus: json['paymentStatus'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
