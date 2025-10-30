import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/general_button.dart';

class CustomDoctorInfoText extends StatelessWidget {
  const CustomDoctorInfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Dr. Disha",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "General Physician",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        Spacer(),

        SizedBox(
          width: 90,

          child: GeneralButton(onPressed: () {}, text: 'Book', height: 25),
        ),
      ],
    );
  }
}
