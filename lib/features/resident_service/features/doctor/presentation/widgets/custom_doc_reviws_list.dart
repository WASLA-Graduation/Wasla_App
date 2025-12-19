import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasla/core/models/review_model.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_review_item.dart';

class DoctorReviewsList extends StatelessWidget {
  const DoctorReviewsList({super.key, required this.length, this.shrinkWrap});

  final int length;
  final bool? shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        return state is DoctorGetReviwesLoading
            ? _loadingList()
            : ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                shrinkWrap: shrinkWrap ?? false,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 0.019,
                  color: AppColors.gray,
                  height: 20,
                ),
                itemCount: cubit.reviewList.length < length
                    ? cubit.reviewList.length
                    : length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    CustomReviewItem(reviewModel: cubit.reviewList[index]),
              );
      },
    );
  }

  Skeletonizer _loadingList() {
    return Skeletonizer(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 20),
        shrinkWrap: shrinkWrap ?? false,
        separatorBuilder: (context, index) =>
            const Divider(thickness: 0.019, color: AppColors.gray, height: 20),
        itemCount: 8,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => CustomReviewItem(
          reviewModel: ReviewModel(
            comment: "",
            createdAt: DateTime.now(),
            rating: 0,
            reviewerName: "",
            userImageUrl: "",
            userId: '',
            reviewId: 1,
          ),
        ),
      ),
    );
  }
}
