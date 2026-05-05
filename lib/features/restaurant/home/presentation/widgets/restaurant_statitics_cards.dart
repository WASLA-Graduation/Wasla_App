import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doc_dashboard_card.dart';
import 'package:wasla/features/restaurant/home/presentation/manager/cubit/restaurant_dashboard_cubit.dart';

class RestaurantStatiticsCards extends StatelessWidget {
  const RestaurantStatiticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantDashboardCubit>();
    return Column(
      spacing: 20,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "numberOfReservations".tr(context),
                value:
                    cubit.restaurantChart?.numberOfReservations.toString() ??
                    0.toString(),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomDocDashboardCard(
                title: "completedBookings".tr(context),
                value:
                    cubit.restaurantChart?.numOfCompletedOrders.toString() ??
                    0.toString(),
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "numOfOrders".tr(context),
                value:
                    "${cubit.restaurantChart?.numOfOrders.toStringAsFixed(0) ?? 0} ",
              ),
            ),
            const SizedBox(width: 15),

            Expanded(
              child: CustomDocDashboardCard(
                title: "totalRevenue".tr(context),
                value:
                    "${cubit.restaurantChart?.totalAmount.toStringAsFixed(0) ?? 0} ${'egb'.tr(context)}",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
