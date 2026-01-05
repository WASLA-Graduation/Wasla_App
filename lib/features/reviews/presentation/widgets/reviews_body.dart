import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_reviws_list.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_rating_list.dart';

class ReviewdBody extends StatelessWidget {
  const ReviewdBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReviewsListByRating(),
          const SizedBox(height: 20),
          BlocBuilder<ReviewsCubit, ReviewsState>(
            builder: (context, state) {
              return ReviewsList(
                length: context.read<ReviewsCubit>().reviewList.length,
                shrinkWrap: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
