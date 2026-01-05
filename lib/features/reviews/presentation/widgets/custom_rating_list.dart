import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_rating_widget.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class ReviewsListByRating extends StatelessWidget {
  const ReviewsListByRating({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReviewsCubit>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          return Row(
            children: List.generate(6, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => cubit.changeRatingIndex(index, 6 - index),
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
