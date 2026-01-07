import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/doc_booking_list.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/doc_chart_dev.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/doc_dash_cards_data.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class DoctorDashboardContent extends StatelessWidget {
  const DoctorDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 25,
      children: [
        DoctorDashboardCardData(),
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
        CustomDoctorDashboardChartDev(),
        DoctorBookingList(),
      ],
    );
  }
}
