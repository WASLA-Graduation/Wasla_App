part of 'payment_cubit.dart';

sealed class PaymentState {
  const PaymentState();
}

final class PaymentInitial extends PaymentState {}

///basic 3 states

final class PaymentNetworkState extends PaymentState {}

final class PaymentFailureState extends PaymentState {}

final class PaymentOnRetryState extends PaymentState {}

///basic 3 states

final class GetPaymentLoadingState extends PaymentState {}

final class GetPaymentLoadedState extends PaymentState {
  final List<BasePaymentModel> payments;

  GetPaymentLoadedState({required this.payments});
}
