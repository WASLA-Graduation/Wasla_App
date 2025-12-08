import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';

class CustomResidentBookingTaps extends StatelessWidget {
  CustomResidentBookingTaps({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentBookingCubit>();
    return BlocBuilder<ResidentBookingCubit, ResidentBookingState>(
      builder: (context, state) {
        return Row(
          spacing: 10,
          children: List.generate(
            3,
            (index) => Expanded(
              child: CustomTapWidget(
                title: titles[index].tr(context),
                onTap: () {
                  cubit.updateCurrentTap(index: index);
                  cubit.getBookingByCurrentTap();
                },
                isSelected: cubit.currentTap == index,
              ),
            ),
          ),
        );
      },
    );
  }

  final List<String> titles = ['upComing', 'completed', 'cancelled'];
}

class CustomTapWidget extends StatelessWidget {
  const CustomTapWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.isSelected,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 7,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: AppColors.gray),
          ),
          Opacity(
            opacity: isSelected ? 1 : 0,
            child: Container(
              width: double.infinity,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
