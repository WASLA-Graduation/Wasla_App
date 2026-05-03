import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/resident_home_body.dart';

class ResidentHomeView extends StatefulWidget {
  const ResidentHomeView({super.key});

  @override
  State<ResidentHomeView> createState() => _ResidentHomeViewState();
}

class _ResidentHomeViewState extends State<ResidentHomeView> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocStatusHandler<HomeResidentCubit, HomeResidentState>(
        body: SafeArea(child: const ResidentHomeBody()),
        onRetry: () {
          context.read<HomeResidentCubit>().onRetry();
          getData();
        },
        isNetwork: (state) => state is HomeResidentNetworkState,
        isError: (state) => state is HomeResidentFailureState,
        buildWhen: (previous, current) =>
            current is HomeResidentNetworkState ||
            current is HomeResidentFailureState ||
            current is HomeResidentOnRetryState,
      ),
    );
  }

  void getData() async {
    final cubit = context.read<HomeResidentCubit>();
    cubit.getResidentProfile();
    cubit.getRecommendedServiceProviders();
    cubit.getServiceProvidersTopOfTheWeek();
  }
}
