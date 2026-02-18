import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/widgets/custom_home_app_bar.dart';
import 'package:wasla/core/widgets/dashbord%20and%20charts/custom_general_dashbord_drop_down.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/widgets/gym_data_card.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/widgets/gym_booking_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class GymDashBoardContent extends StatelessWidget {
  const GymDashBoardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymDashboardCubit>();
    return Column(
      spacing: 25,
      children: [
        CustomHomeAppBar(
          isLoading: cubit.gym == null,
          userName: cubit.gym?.ownerName,
          imageUrl: cubit.gym?.profilePhoto,
          onNotificationTap: () {},
          onBookmarkTap: () {},
          showBookmark: false,
        ),
        GymDashboardDataCard(),
        DashboardChartCard(
          title: 'monthlyRevenue'.tr(context),
          years:
              cubit.gymStatisticsModel?.years.map((e) => e.year).toList() ??
              [DateTime.now().year],
          selectedYear: cubit.initalSelectedYear,
          onYearChanged: (year) {
            cubit.getChartDataByYear(year: int.parse(year!));
          },
          yearDataModel: cubit.yearDataModel,
        ),
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
        GymBookingList(),
      ],
    );
  }
}
