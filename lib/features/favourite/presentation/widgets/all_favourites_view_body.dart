import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/favourite/presentation/widgets/fav_item.dart';

class AllFavouritesViewBody extends StatelessWidget {
  const AllFavouritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavouriteCubit>();
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        if (state is GetFavouriteFailure) {
          return Center(
            child: Column(
              children: [
                Image.asset(Assets.assetsImagesError, height: 200),
                const SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "errorFetchData".tr(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetFavouriteLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.allFavouriteList.isEmpty
              ? Center(
                  child: Text(
                    "noFavourites".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 0),
                  separatorBuilder: (_, index) => const SizedBox(height: 5),
                  itemCount: cubit.allFavouriteList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () async {
                        await cubit.getDoctorData(
                          doctorId:
                              cubit.allFavouriteList[index].serviceProviderId,
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
                      },
                      child: FavItem(
                        serviceProviderModel: cubit.allFavouriteList[index],
                      ),
                    ),
                  ),
                );
        }
      },
    );
  }
}
