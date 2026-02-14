import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/gym_del_upd_bottom_sheet.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/gym_package_item.dart';

// ignore: must_be_immutable
class PackagesOffersList extends StatelessWidget {
  PackagesOffersList({super.key});
  List<GymPackageModel> data = [];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return BlocBuilder<GymPackagesCubit, GymPackagesState>(
      builder: (context, state) {
        if (state is GymGetPackagesAndOffersError) {
          return CustomErrGetData();
        } else if (state is GymGetPackagesAndOffersLoading || state is GymDeletePackagesAndOffersLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          if (state is GymGetPackagesAndOffersSuccess  ) {
            data = state.data;
          }

          return data.isEmpty
              ? Center(
                  child: Text(
                    cubit.tapsCurrentIndex == 0
                        ? "noPackages".tr(context)
                        : "noOffers".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: .7,
                  ),
                  itemCount: data.length,
                  // itemCount: 5,
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPress: () => showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          GymDeleteUpdateModelSheet(packageId: data[index].id),
                    ),
                    child: GymPackageItem(model: data[index]),
                  ),
                );
        }
      },
    );
  }
}


