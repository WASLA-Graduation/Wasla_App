import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/resident_booking_body.dart';

class ResidentBookingView extends StatefulWidget {
const ResidentBookingView({super.key});

  @override
  State<ResidentBookingView> createState() => _ResidentBookingViewState();
}

class _ResidentBookingViewState extends State<ResidentBookingView> {
  @override
  void initState() {
    resetState();
    getResidentBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: [CustomMoreAppBarWidget(image: Assets.assetsImagesSearch)],
        title: Text(
          "myBookings".tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
        child: ResidentBookingBody(),
      ),
    );
  }

  void resetState() {
    context.read<ResidentBookingCubit>().currentTap = 0;
  }

  void getResidentBookings() async {
    context.read<ResidentBookingCubit>().getResidentBookings();
  }
}
