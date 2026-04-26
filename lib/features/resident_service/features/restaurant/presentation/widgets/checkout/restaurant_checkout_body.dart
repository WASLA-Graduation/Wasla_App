import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/helpers/url_helper.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/cart/restaurant_cart_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/cart/restaurnt_checkout_widget.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/checkout/restaurant_checkout_field.dart';

class RestaurantCheckoutBody extends StatelessWidget {
  RestaurantCheckoutBody({
    super.key,
    required this.restaurantId,
    required this.orederIdCallBack,
  });
  final String restaurantId;
  final ValueChanged<int> orederIdCallBack;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String adress = '';
    String notes = '';
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: RestaurantCheckoutField(
                    validator: (value) => validateSimpleData(value, context),
                    title: 'address'.tr(context),
                    callback: (add) {
                      adress = add;
                    },
                  ),
                ),
                SizedBox(height: AppSizes.paddingSizeFifteen),
                RestaurantCheckoutField(
                  title: 'notes'.tr(context),
                  callback: (note) {
                    notes = note;
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSizes.paddingSizeThelve),
        BlocConsumer<RestaurantCartCubit, RestaurantCartState>(
          listenWhen: (previous, current) =>
              current is RestaurantCartCheckoutState,
          buildWhen: (previous, current) =>
              current is RestaurantCartCheckoutState,
          listener: (context, state) {
            if (state is RestaurantCartCheckoutSuccessState) {
              ///launch url
              UrlHelper.openWebsite(state.paymentModel.paymentKey);
              orederIdCallBack(state.paymentModel.orderId);
            } else if (state is RestaurantCartCheckoutFailureState) {
              showToast(state.errMsg, color: Colors.red);
            }
          },
          builder: (context, state) {
            return RestaurantCheckoutWiget(
              restaurantId: restaurantId,
              onTap: () {
                final cubit = context.read<RestaurantCartCubit>();
                if (cubit.state is! RestaurantCartCheckoutLoadingState &&
                    formKey.currentState!.validate()) {
                  context.read<RestaurantCartCubit>().checkOut(
                    address: adress,
                    notes: notes,
                    restaurantId: restaurantId,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
