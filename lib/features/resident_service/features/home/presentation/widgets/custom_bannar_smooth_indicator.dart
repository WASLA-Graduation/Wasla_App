import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class CustomBannarSmoothIndicator extends StatelessWidget {
  const CustomBannarSmoothIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeResidentCubit, HomeResidentState>(
      builder: (context, state) {
        final cubit = context.read<HomeResidentCubit>();
        return Padding(
          padding: context.isArabic
              ? const EdgeInsets.only(bottom: 10, left: 60)
              : const EdgeInsets.only(bottom: 10, right: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 5),
                width: cubit.currentIndex == index ? 20 : 10,
                height: 7,
                decoration: BoxDecoration(
                  color: cubit.currentIndex == index
                      ? AppColors.whiteColor
                      : AppColors.whiteColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
