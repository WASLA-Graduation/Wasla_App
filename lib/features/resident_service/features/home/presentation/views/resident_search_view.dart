import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/resident_seach_body.dart';

class ResidentSearchView extends StatefulWidget {
  const ResidentSearchView({super.key});

  @override
  State<ResidentSearchView> createState() => _ResidentSearchViewState();
}

class _ResidentSearchViewState extends State<ResidentSearchView> {
  @override
  void initState() {
    getAllServiceProviders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('searchServices'.tr(context))),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeDefault,
        ),

        child: BlocStatusHandler<HomeResidentCubit, HomeResidentState>(
          body: const ResidentSearchBody(),
          onRetry: () {
            context.read<HomeResidentCubit>().onRetry();
            getAllServiceProviders();
          },
          isNetwork: (state) => state is HomeResidentNetworkState,
          isError: (state) => state is HomeResidentFailureState,
          buildWhen: (previous, current) =>
              current is HomeResidentNetworkState ||
              current is HomeResidentFailureState ||
              current is HomeResidentOnRetryState,
        ),
      ),

      resizeToAvoidBottomInset: false,
    );
  }

  void getAllServiceProviders() {
    final cubit = context.read<HomeResidentCubit>();
    cubit.reset();
    cubit.getAllServiceProviders(fromPagination: false);
  }
}
