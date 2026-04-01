import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class DriverArrivedBottomSheet extends StatelessWidget {
  const DriverArrivedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UnderLineWidget(),
          const SizedBox(height: 20),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            'driverArrived'.tr(context),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'driverWaiting'.tr(context),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleNeworkImage(
                  imageUrl: context.read<HomeResidentCubit>().user!.imageUrl,
                  isLoading: false,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              'Mostafa Salah',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.star,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                          Text(
                            '4.8',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        'BMW M5 · White · ABC-1234',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          GeneralButton(
            onPressed: () {
              context.pop();
            },
            text: 'gotIt'.tr(context),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
