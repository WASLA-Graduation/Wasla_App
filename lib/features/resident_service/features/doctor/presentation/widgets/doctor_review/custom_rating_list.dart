import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_rating_widget.dart';

class DoctorReviewsListByRating extends StatelessWidget {
  const DoctorReviewsListByRating({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          return Row(
            children: List.generate(6, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => cubit.changeRatingIndex(index,6-index),
                  child: CustomRatingWidget(
                    rating: index == 0 ? "All" : "${6 - index}",
                    isSelected: cubit.ratingIndex == index,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}