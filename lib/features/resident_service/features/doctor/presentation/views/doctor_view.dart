import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_view_body.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  @override
  void initState() {
    getDoctorSpeciality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors"),
        forceMaterialTransparency: true,
        actions: _buildAppBarActons,
      ),

      body: DoctorViewBody(),
    );
  }

  List<Widget> get _buildAppBarActons {
    return [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            Assets.assetsImagesSearch,
            width: 21,
            color: AppColors.gray,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 7),
          child: IconButton(
            onPressed: () {},
            icon: Image.asset(
              Assets.assetsImagesMore,
              width: 21,
              color: AppColors.gray,
            ),
          ),
        ),
      ];
  }

  void getDoctorSpeciality() async =>
      context.read<DoctorCubit>().getDoctorSpecialization();
}
