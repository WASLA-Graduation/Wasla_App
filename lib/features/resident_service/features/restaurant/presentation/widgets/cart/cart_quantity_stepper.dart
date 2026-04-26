import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_cart_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/cart/restaurant_cart_cubit.dart';

class CartQuantityStepper extends StatelessWidget {
  const CartQuantityStepper({super.key, required this.item});

  final RestaurantCartModel item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantCartCubit>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepBtn(
          icon: Icons.remove,
          onTap: () {
            cubit.updatItemQuantity(item, isIncrement: false);
          },
          itemId: item.menuItemId,
        ),
        SizedBox(
          width: 28,
          child: BlocBuilder<RestaurantCartCubit, RestaurantCartState>(
            buildWhen: (previous, current) =>
                current is RestaurantCartUpadteQuantityState && current.itemId == item.cartItemId,
            builder: (context, state) {
              return Text(
                item.quantity.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        _StepBtn(
          icon: Icons.add,
          onTap: () {
            cubit.updatItemQuantity(item, isIncrement: true);
          },
          itemId: item.menuItemId,
        ),
      ],
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({
    required this.icon,
    required this.onTap,
    required this.itemId,
  });

  final IconData icon;
  final VoidCallback onTap;
  final int itemId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Icon(icon, size: 14, color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}
