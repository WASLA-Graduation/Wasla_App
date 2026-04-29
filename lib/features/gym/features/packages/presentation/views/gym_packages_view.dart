import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
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
        body: BlocStatusHandler<GymPackagesCubit, GymPackagesState>(
        body: const GymPackageViewBody(),
        onRetry: () {
          context.read<GymPackagesCubit>().onRetry();
          getGymPackagesAndOffers();
        },
        isNetwork: (state) => state is GymPackagesNetworkState,
        isError: (state) => state is GymPackagesFailureState,
        buildWhen: (previous, current) =>
            current is GymPackagesNetworkState ||
            current is GymPackagesFailureState ||
            current is GymPackagesOnRetryState,
      )
      ),
    );
  }

  getGymPackagesAndOffers() async {
    context.read<GymPackagesCubit>().tapsCurrentIndex = 0;
    await context.read<GymPackagesCubit>().getGymPackagesAndOffers();
  }
}
