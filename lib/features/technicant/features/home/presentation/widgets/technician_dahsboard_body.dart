import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';
import 'package:wasla/features/technicant/features/home/presentation/widgets/techincian_dashboard_appbar.dart';
import 'package:wasla/features/technicant/features/home/presentation/widgets/technician_statistics.dart';

class TechincianDashboardBody extends StatefulWidget {
  const TechincianDashboardBody({super.key});

  @override
  State<TechincianDashboardBody> createState() =>
      _TechincianDashboardBodyState();
}

class _TechincianDashboardBodyState extends State<TechincianDashboardBody> {
  TechnicianModel? technician;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: TechnicianDahsboardAppBar()),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          TechnicianStatistics(),
        ],
      ),
    );
  }
}
