import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/service_provider_type.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/service/payment/payment_service.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/gym_resident_see_packages_body.dart';

class ResidentGymSeePakcagesView extends StatefulWidget {
  const ResidentGymSeePakcagesView({super.key, required this.gymId});
  final String gymId;

  @override
  State<ResidentGymSeePakcagesView> createState() =>
      _ResidentGymSeePakcagesViewState();
}

class _ResidentGymSeePakcagesViewState
    extends State<ResidentGymSeePakcagesView> {
  late final AppLifecycleListener listner;
  @override
  void initState() {
    getPackages();
    listner = AppLifecycleListener(
      onResume: () {
        checkPaymentStatus();
      },
    );
    super.initState();
  }

  void checkPaymentStatus() async {
    final cubit = context.read<GymResidentCubit>();
    final int bookingId = cubit.bookingReturnedDataModel?.bookingId ?? -1;
    if (bookingId != -1) {
      final result = await PaymentService.checkPaymentStatus(
        entityType: EntityType.booking,
        entityId: bookingId,
      );
      cubit.bookingReturnedDataModel!.bookingId = -1;
      result.fold((err) {}, (isPaid) {
        if (isPaid) {
          showToast('bookingWithGym'.tr(context), color: AppColors.acceptGreen);
          context.pop();
        }
      });
    }
  }

  @override
  void dispose() {
    listner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("packages".tr(context)),
      ),
      body: BlocStatusHandler<GymResidentCubit, GymResidentState>(
        body: const ResidentGymSeePakcagesViewBody(),
        onRetry: () {
          context.read<GymResidentCubit>().onRetry();
          getPackages();
        },
        isNetwork: (state) => state is GymResidentNetworkState,
        isError: (state) => state is GymResidentFailureState,
        buildWhen: (previous, current) =>
            current is GymResidentNetworkState ||
            current is GymResidentFailureState ||
            current is GymResidentOnRetryState,
      ),
    );
    // child: const ResidentGymSeePakcagesViewBody(),
  }

  void getPackages() {
    context.read<GymResidentCubit>().getGymPackages(gymId: widget.gymId);
  }
}
