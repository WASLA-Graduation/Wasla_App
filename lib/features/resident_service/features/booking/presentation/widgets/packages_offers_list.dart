import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/gym_del_upd_bottom_sheet.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/gym_package_item.dart';

class PackagesOffersList extends StatefulWidget {
  const PackagesOffersList({super.key});

  @override
  State<PackagesOffersList> createState() => _PackagesOffersListState();
}

class _PackagesOffersListState extends State<PackagesOffersList> {
  List<GymPackageModel> data = [];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return BlocBuilder<GymPackagesCubit, GymPackagesState>(
      builder: (context, state) {
        if (state is GymGetPackagesAndOffersLoading ||
            state is GymDeletePackagesAndOffersLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          if (state is GymGetPackagesAndOffersSuccess) {
            data = state.data;
          }

          return data.isEmpty
              ? EmptyStateWidget()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: .66,
                  ),
                  itemCount: data.length,
                  // itemCount: 5,
                  itemBuilder: (context, index) =>
                      BlocConsumer<GymPackagesCubit, GymPackagesState>(
                        listener: (context, state) {
                          if (state is GymDeletePackagesAndOffersSuccess) {
                            toastAlert(
                              color: AppColors.primaryColor,
                              msg: cubit.tapsCurrentIndex == 0
                                  ? "packageDeleted".tr(context)
                                  : "offerDeleted ".tr(context),
                            );
                          }
                          if (state is GymDeletePackagesAndOffersError) {
                            toastAlert(
                              color: Colors.red,
                              msg: state.errorMessage,
                            );
                          }
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onLongPress: () => showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  GymDeleteUpdateModelSheet(model: data[index]),
                            ),
                            child: GymPackageItem(model: data[index]),
                          );
                        },
                      ),
                );
        }
      },
    );
  }
}
