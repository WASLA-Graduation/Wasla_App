import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/payment/data/models/base_payment_model.dart';
import 'package:wasla/features/payment/payment_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.payment) : super(PaymentInitial());
  final PaymentService payment;

  void onRetry() {
    emit(PaymentOnRetryState());
  }

  Future<void> getPaymets() async {
    final String? role =
        SharedPreferencesHelper.get(key: ApiKeys.role) as String?;

    if (role == ServiceRole.resident.name) {
      getResidentPayments();
    } else {
      getServiceProviderPayments();
    }
  }

  Future<void> getResidentPayments() async {
    emit(GetPaymentLoadingState());
    final String? residentId = await getUserId();

    final result = await payment.getResidentPayments(residentId: residentId!);

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(PaymentNetworkState());
        } else {
          emit(PaymentFailureState());
        }
      },
      (payments) {
        emit(GetPaymentLoadedState(payments: payments));
      },
    );
  }

  Future<void> getServiceProviderPayments() async {
    emit(GetPaymentLoadingState());
    final String? serviceProviderId = await getUserId();

    final result = await payment.getServiceProviderPayments(
      serviceProvider: serviceProviderId!,
    );

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(PaymentNetworkState());
        } else {
          emit(PaymentFailureState());
        }
      },
      (payments) {
        emit(GetPaymentLoadedState(payments: payments));
      },
    );
  }
}
