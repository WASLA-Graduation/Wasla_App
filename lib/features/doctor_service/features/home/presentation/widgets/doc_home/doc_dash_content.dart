import 'package:flutter/material.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/doc_booking_list.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/doc_chart_dev.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/doc_dash_cards_data.dart';

class DoctorDashboardContent extends StatelessWidget {
  const DoctorDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 25,
      children: [
        DoctorDashboardCardData(),
        CustomDoctorDashboardChartDev(),
        DoctorBookingList(),
      ],
    );
  }
}
