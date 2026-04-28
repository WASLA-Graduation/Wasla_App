import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/service/payment/payment_service.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/checkout/restaurant_checkout_body.dart';

class RestaurantCheckoutView extends StatefulWidget {
  const RestaurantCheckoutView({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  State<RestaurantCheckoutView> createState() => _RestaurantCheckoutViewState();
}

class _RestaurantCheckoutViewState extends State<RestaurantCheckoutView> {
  late final AppLifecycleListener listner;
  int orderId = -1;
  @override
  void initState() {
    super.initState();
    listner = AppLifecycleListener(
      onResume: () {
        checkPaymentStatus(orderId);
      },
    );
  }

  void checkPaymentStatus(int orderId) async {
    if (orderId != -1) {
      final result = await PaymentService.checkPaymentStatus(entityId: orderId);
      this.orderId = -1;
      result.fold((err) {}, (isPaid) {
        if (isPaid) {
          showToast('orderWillPrep'.tr(context), color: AppColors.acceptGreen);
          context.pop();
          context.pushReplacement(AppRoutes.residentRestaurantOrdersScreen);
        }
      });
    }
  }

  @override
  void dispose() {
    listner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('checkout'.tr(context))),
      body: RestaurantCheckoutBody(
        restaurantId: widget.restaurantId,
        orederIdCallBack: (value) => orderId = value,
      ),
    );
  }
}
