import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/reservations/reservation_pagination_list.dart';

class ReservationBody extends StatefulWidget {
  const ReservationBody({super.key});

  @override
  State<ReservationBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<ReservationBody> {
  List<RestaurantReservationModel> reservations = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.marginDefault,
      ),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        buildWhen: (previous, current) =>
            current is GetRestaurantReservationsLoadingState ||
            current is GetRestaurantReservationsLoadedState,
        builder: (context, state) {
          if (state is GetRestaurantReservationsLoadingState ||
              state is OrdersInitial) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
            );
          } else if (state is GetRestaurantReservationsLoadedState) {
            reservations.addAll(state.reservations);
          }

          return reservations.isEmpty
              ? EmptyStateWidget(
                  message: 'noReservationsAtTheMoment'.tr(context),
                  title: 'noReservations'.tr(context),
                )
              : ReservationPaginationList(reservations: reservations);
        },
      ),
    );
  }
}
