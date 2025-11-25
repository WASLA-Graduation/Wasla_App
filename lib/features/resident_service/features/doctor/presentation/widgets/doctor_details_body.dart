import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_circle_with_data_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_details_card_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_review_item.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';

class DoctorDetailsBody extends StatelessWidget {
  const DoctorDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      children: [
        CustomDoctorDatailsCardWeiget(),
        const SizedBox(height: 18),
        CustomCircleWithDataList(),
        const SizedBox(height: 20),
        Text("About Me", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        ReadmoreText(
          maxLines: 3,
          text:
              'A dedicated doctor providing accurate diagnosis and personalized care with a friendly, professional approach. Always committed to ensuring patient comfort and the best treatment outcomes.',
        ),
        const SizedBox(height: 20),
        TextDetailsIdentfierWidget(
          leading: "Working Time",
          trailing: "See Services",
        ),
        const SizedBox(height: 5),
        Text(
          "Monday-Friday,9:00 AM-20:00 PM",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 10),
        TextDetailsIdentfierWidget(leading: "Reviwes", trailing: "See All"),
        const SizedBox(height: 20),
        CustomReviewItem(),
      ],
    );
  }
}
