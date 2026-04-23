import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/restaurant_reservation_item.dart';

class ResturantPaginationOrders extends StatelessWidget {
  const ResturantPaginationOrders({super.key, required this.reservations});

  final List<RestaurantReservationModel> reservations;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: () async {
        context.read<OrdersCubit>().getRestaurantsReservations(
          fromPagination: true,
        );
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              physics: const BouncingScrollPhysics(),
              itemCount: reservations.length,
              itemBuilder: (context, index) => RestaurantResevationItem(
                reservation: reservations.elementAt(index),
              ),
            ),
          ),

          BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return state
                      is GetRestaurantReservationsFromPaginationLoadingState
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
