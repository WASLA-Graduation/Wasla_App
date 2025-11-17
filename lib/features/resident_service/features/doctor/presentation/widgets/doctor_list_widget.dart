import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_list_item.dart';

class DoctorListWidget extends StatelessWidget {
  const DoctorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => const SizedBox(height: 5,),
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () {
          },
          child: DoctorListItem(),
        ),
      ),
    );
  }
}
