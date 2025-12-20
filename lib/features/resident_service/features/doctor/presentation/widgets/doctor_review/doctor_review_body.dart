import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_reviws_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_review/custom_rating_list.dart';

class DoctorReviewBody extends StatelessWidget {
  const DoctorReviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DoctorReviewsListByRating(),
          const SizedBox(height: 20),
          BlocBuilder<DoctorCubit, DoctorState>(
            builder: (context, state) {
              return DoctorReviewsList(
                length: context.read<DoctorCubit>().reviewList.length,
                shrinkWrap: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
