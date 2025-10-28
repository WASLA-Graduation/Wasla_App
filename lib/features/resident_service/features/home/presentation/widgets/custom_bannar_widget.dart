import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_bannar_item.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_bannar_smooth_indicator.dart';

class CustomBannarWidget extends StatelessWidget {
  const CustomBannarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,

      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),

      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              context.read<HomeResidentCubit>().updateCurrentIndex(index);
            },
            itemCount: 3,
            itemBuilder: (context, index) => CustomBannarItem(),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBannarSmoothIndicator(),
          ),
        ],
      ),
    );
  }
}
