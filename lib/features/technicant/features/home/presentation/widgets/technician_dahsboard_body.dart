import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TechincianDashboardBody extends StatelessWidget {
  const TechincianDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      children: [
        Container(height: 200, color: Colors.red),
        Container(height: 200, color: Colors.green),
        Container(height: 200, color: Colors.blue),
      ],
    );
  }
}
