import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';

class CustomAddReviweWidget extends StatefulWidget {
  const CustomAddReviweWidget({super.key, required this.doctorId});

  final String doctorId;

  @override
  State<CustomAddReviweWidget> createState() => _CustomAddReviweWidgetState();
}

class _CustomAddReviweWidgetState extends State<CustomAddReviweWidget> {
  @override
  void dispose() {
    reviewValueController.dispose();

    super.dispose();
  }

  final reviewValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        return Column(
          spacing: 10,
          children: [
            Row(
              spacing: 5,
              children: List.generate(5, (index) {
                return InkWell(
                  onTap: () {
                    cubit.toggleRatingStars(index + 1);
                  },
                  child: Icon(
                    Icons.star,
                    color: cubit.starsIds.contains(index + 1)
                        ? AppColors.primaryColor
                        : AppColors.gray,
                    size: 22,
                  ),
                );
              }),
            ),

            TextField(
              controller: reviewValueController,
              onChanged: (value) {
                cubit.updateReviewValue(value);
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Image.asset(
                    color: AppColors.primaryColor,
                    width: 25,
                    cubit.reviewValue.isEmpty
                        ? Assets.assetsImagesSendOutlined
                        : Assets.assetsImagesSendFilled,
                  ),
                  onPressed: () async {
                    if (cubit.reviewValue.isNotEmpty) {
                      cubit.addReview(widget.doctorId);
                      reviewValueController.clear();
                    }
                  },
                ),
                hintText: "writeReview".tr(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
