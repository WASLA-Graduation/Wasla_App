import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/resident_service/features/home/data/models/service_provieders_search_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/search/resident_search_item.dart';

class ResidentSearchList extends StatelessWidget {
  const ResidentSearchList({super.key, required this.serviceProviders});
  final List<ServiceProviedersSearchModel> serviceProviders;
  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: () async {
        final cubit = context.read<HomeResidentCubit>();
        if (cubit.isSearch) {
          cubit.searchInAllServiceProviders(fromPagination: true);
        } else {
          cubit.getAllServiceProviders(fromPagination: true);
        }
      },
      child: Column(
        children: [
          SizedBox(height: AppSizes.paddingSizeEight),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: serviceProviders.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  final cubit = context.read<FavouriteCubit>();
                  switch (ServiceRole.fromString(
                    serviceProviders.elementAt(index).role,
                  )) {
                    case ServiceRole.doctor:
                      await cubit.getDoctorData(
                        doctorId: serviceProviders[index].id,
                      );
                      if (cubit.doctorDataModel != null) {
                        context.pushScreen(
                          AppRoutes.doctorDetailsScreen,
                          arguments: cubit.doctorDataModel,
                        );
                      } else {
                        toastAlert(
                          color: AppColors.error,
                          msg: "Something went wrong",
                        );
                      }
                      break;

                    case ServiceRole.restaurantOwner:
                      context.pushScreen(
                        AppRoutes.residentRestaurantDetailsScreen,
                        arguments: {
                          AppStrings.name: serviceProviders[index].name,
                          AppStrings.id: serviceProviders[index].id,
                        },
                      );
                      break;
                    case ServiceRole.driver:
                      return;
                    case ServiceRole.gymOwner:
                      context.pushScreen(
                        AppRoutes.gymResidentDetailsScreen,
                        arguments: {
                          AppStrings.gymName: serviceProviders[index].name,
                          AppStrings.gymId: serviceProviders[index].id,
                        },
                      );
                      break;

                    case ServiceRole.technician:
                      context.pushScreen(
                        AppRoutes.residentTechnicianDetailsScreen,
                        arguments: {
                          AppStrings.name: serviceProviders[index].name,
                          AppStrings.id: serviceProviders[index].id,
                        },
                      );
                      break;
                  }
                },
                child: ResidentSearchItem(
                  serviceProviderModel: serviceProviders.elementAt(index),
                ),
              ),
            ),
          ),

          BlocBuilder<HomeResidentCubit, HomeResidentState>(
            builder: (context, state) {
              return state is HomeResidentGetServicesLoadingFromPagination
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
