import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_list_item.dart';

class DoctorListWidget extends StatelessWidget {
  const DoctorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: BouncingScrollPhysics(),

      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: DoctorListItem(),
      ),
    );
  }
}
