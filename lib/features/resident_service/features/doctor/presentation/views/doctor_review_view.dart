import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_review/doctor_review_body.dart';

class DoctorReviewView extends StatelessWidget {
  const DoctorReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("All Reviews"),
        actions: [CustomMoreAppBarWidget()],
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: DoctorReviewBody(),
      ),
    );
  }
}
