import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/home/data/models/service_provieders_search_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/search/custom_not_found_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/search/custom_search_bar.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/search/resident_search_list.dart';

class ResidentSearchBody extends StatefulWidget {
  const ResidentSearchBody({super.key});

  @override
  State<ResidentSearchBody> createState() => _ResidentSearchBodyState();
}

class _ResidentSearchBodyState extends State<ResidentSearchBody> {
  List<ServiceProviedersSearchModel> serviceProviders = [];

  final TextEditingController searchController = TextEditingController();
  Timer? debounceTimer;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeResidentCubit>();
    return Column(
      spacing: AppSizes.paddingSizeDefault,
      children: [
        BlocBuilder<HomeResidentCubit, HomeResidentState>(
          buildWhen: (previous, current) =>
              current is HomeResidentCloseSearchBar,
          builder: (context, state) {
            return CustomSearchBar(
              controller: searchController,
              isClose: cubit.isCloseSearch,
              onChanged: (value) {
                cubit.query = value;
                cubit.whenUserSearch();
                if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
                debounceTimer = Timer(const Duration(milliseconds: 800), () {
                  cubit.searchInAllServiceProviders(fromPagination: false);
                });
              },
              readOnly: false,
            );
          },
        ),
        BlocBuilder<HomeResidentCubit, HomeResidentState>(
          buildWhen: (previous, current) =>
              current is HomeResidentGetServicesLoading ||
              current is HomeResidentGetServicesLoaded,
          builder: (context, state) {
            if (state is HomeResidentGetServicesLoading ||
                state is HomeResidentInitial) {
              return Expanded(
                child: Center(
                  child: SpinKitFadingCircle(
                    color: AppColors.primaryColor,
                    size: 50.0,
                  ),
                ),
              );
            } else if (state is HomeResidentGetServicesLoaded) {
              serviceProviders = state.serviceProviders;
            }

            return serviceProviders.isEmpty
                ? Expanded(child: CustomNotFoundWidget())
                : Expanded(
                    child: ResidentSearchList(
                      serviceProviders: serviceProviders,
                    ),
                  );
          },
        ),
        // Expanded(child: CustomNotFoundWidget()),
      ],
    );
  }
}
