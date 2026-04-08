import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/dashbord%20and%20charts/custom_general_dashbord_drop_down.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';
import 'package:wasla/features/technicant/features/home/presentation/widgets/technician_statistics_cards.dart';

class TechnicianStatistics extends StatelessWidget {
  const TechnicianStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicantDashboardCubit, TechnicantDashboardState>(
      buildWhen: (previous, current) =>
          current is TechnicainGetDashboardDataLoading ||
          current is TechnicainGetDashboardDataSuccess,
      builder: (context, state) {
        if (state is TechnicainGetDashboardDataLoading ||
            state is TechnicantDashboardInitial) {
          return SliverFillRemaining(
            child: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
          );
        }

        return SliverToBoxAdapter(child: TechnicianStatisticsContent());
      },
    );
  }
}

class TechnicianStatisticsContent extends StatelessWidget {
  const TechnicianStatisticsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TechnicantDashboardCubit>();
    final double spacing = SizeConfig.isTablet ? 30.0 : 16.0;

    return Column(
      spacing: spacing,
      children: [
        TechnicianStatisticsCards(),
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
        BlocBuilder<TechnicantDashboardCubit, TechnicantDashboardState>(
          buildWhen: (previous, current) =>
              current is TechnicainGetDashboardDataFromDropDown,
          builder: (context, state) {
            return DashboardChartCard(
              title: 'monthlyRevenue'.tr(context),
              years:
                  cubit.technicianChart?.years.map((e) => e.year).toList() ??
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
