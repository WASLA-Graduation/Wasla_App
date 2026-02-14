import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_package_view_body.dart';

class GymPackagesView extends StatefulWidget {
  const GymPackagesView({super.key});

  @override
  State<GymPackagesView> createState() => _GymPackagesViewState();
}

class _GymPackagesViewState extends State<GymPackagesView> {
  @override
  void initState() {
    getGymPackagesAndOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
          child: const GymPackageViewBody(),
        ),
      ),
    );
  }

  getGymPackagesAndOffers() async {
    context.read<GymPackagesCubit>().tapsCurrentIndex = 0;
    await context.read<GymPackagesCubit>().getGymPackagesAndOffers();
  }
}
