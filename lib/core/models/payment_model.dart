class PaymentModel {
  final String paymentKey;
  final int orderId;

  PaymentModel({required this.paymentKey, required this.orderId});

  factory PaymentModel.fromJson({required Map<String, dynamic> json}) {
    return PaymentModel(
      paymentKey: json['paymentKey'],
      orderId: json['orderId'],
    );
  }
}
