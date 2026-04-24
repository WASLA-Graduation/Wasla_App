import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/dashbord%20and%20charts/custom_general_dashbord_drop_down.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';
import 'package:wasla/features/restaurant/home/presentation/manager/cubit/restaurant_dashboard_cubit.dart';
import 'package:wasla/features/restaurant/home/presentation/widgets/restaurant_statitics_cards.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class RestaurantStatistics extends StatelessWidget {
  const RestaurantStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDashboardCubit, RestaurantDashboardState>(
      buildWhen: (previous, current) =>
          current is RestaurantDashboardGetChartLoading ||
          current is RestaurantDashboardGetChartSuccess,
      builder: (context, state) {
        if (state is RestaurantDashboardGetChartLoading ||
            state is RestaurantDashboardInitial) {
          return SliverFillRemaining(
            child: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
          );
        }

        return SliverToBoxAdapter(child: RestaurantStatisticsContent());
      },
    );
  }
}

class RestaurantStatisticsContent extends StatelessWidget {
  const RestaurantStatisticsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantDashboardCubit>();

    return Column(
      spacing: AppSizes.paddingSizeDefault,
      children: [
        RestaurantStatiticsCards(),
        TextDetailsIdentfierWidget(
          leading: "reviwes".tr(context),
          trailing: "seeAll".tr(context),
          onTap: () async {
            context.pushScreen(AppRoutes.reviewScreen);
            final cubit = context.read<ReviewsCubit>();
            final String? userId = await getUserId();
            cubit.resetState();
            cubit.getReveiws(userId!);
            cubit.selectedUserId = userId;
          },
        ),
        BlocBuilder<RestaurantDashboardCubit, RestaurantDashboardState>(
          buildWhen: (previous, current) =>
              current is RestaurantDashboardGetChartFromDropDown,
          builder: (context, state) {
            return DashboardChartCard(
              title: 'monthlyRevenue'.tr(context),
              years:
                  cubit.restaurantChart?.years.map((e) => e.year).toList() ??
                  [DateTime.now().year],
              selectedYear: cubit.initalSelectedYear,
              onYearChanged: (year) {
                cubit.getChartDataByYear(
                  year: int.parse(year!),
                  fromDropDown: true,
                );
              },
              yearDataModel: cubit.yearDataModel,
            );
          },
        ),
      ],
    );
  }
}
