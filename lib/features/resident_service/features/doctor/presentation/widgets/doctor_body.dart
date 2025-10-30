import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doctors_list.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_search_bar.dart';

class DoctorBody extends StatelessWidget {
  const DoctorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 0),
      child: Column(
        children: [
          CustomSearchBar(
            onChanged: (value) {},
            readOnly: false,
            title: "Search for Doctor",
          ),

          const SizedBox(height: 10),
          Expanded(child: CustomDoctorsList()),
        ],
      ),
    );
  }
}
