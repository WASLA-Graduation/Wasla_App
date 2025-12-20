import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
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
            ? Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          )
            : cubit.reviewList.isEmpty
            ? Center(
                child: Text(
                  "noReviews".tr(context),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )
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


}
