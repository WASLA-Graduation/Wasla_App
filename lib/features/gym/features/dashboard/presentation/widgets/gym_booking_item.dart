import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/booking_status.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/core/widgets/custom_decorated_container.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/widgets/general_confirmation_widget.dart';
import 'package:wasla/features/gym/features/dashboard/data/models/gym_booking_model.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';

class GymBookingItem extends StatelessWidget {
  const GymBookingItem({
    super.key,
    required this.bookingModel,
    required this.index,
  });
  final GymBookingModel bookingModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CustomDecoratedContainer(
      child: Column(
        spacing: 10,
        children: [_leadingWidget(), _contentWidget(context)],
      ),
    );
  }

  Column _contentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        _buildTextWidget(
          context,
          title: "name".tr(context),
          value: bookingModel.name,
        ),
        _buildTextWidget(
          context,
          title: "date".tr(context),
          value: bookingModel.bookingTime.toLocal().toString().split(" ")[0],
        ),
        _buildTextWidget(
          context,
          title: "time".tr(context),
          value: formatDateTimeWithIntl(bookingModel.bookingTime),
        ),
        _buildTextWidget(
          context,
          title: "duration".tr(context),
          value: "${bookingModel.durationInMonths} ${"months".tr(context)}",
        ),
        _buildTextWidget(
          context,
          title: "price".tr(context),
          value: "${bookingModel.price} ${"egb".tr(context)}",
        ),
        _buildTextWidget(
          context,
          title: "package".tr(context),
          value: context.isArabic
              ? bookingModel.serviceName.arabic
              : bookingModel.serviceName.english,
        ),
        const SizedBox(),
        context.read<GymDashboardCubit>().gymBookingsStatus ==
                BookingStatus.active
            ? GymCancelBooking(index: index, gymBookingModel: bookingModel)
            : const SizedBox(),
      ],
    );
  }

  Align _leadingWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: SizedBox(
          height: 80,
          width: 80,

          child: CustomCachedNetworkImage(
            imageUrl: bookingModel.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Text _buildTextWidget(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Text.rich(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      TextSpan(
        children: [
          TextSpan(
            text: "$title : ",
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w900),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}

class GymCancelBooking extends StatelessWidget {
  const GymCancelBooking({
    super.key,
    required this.index,
    required this.gymBookingModel,
  });

  final int index;
  final GymBookingModel gymBookingModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymDashboardCubit>();
    return BlocConsumer<GymDashboardCubit, GymDashboardState>(
      listener: (context, state) {
        if (state is GymDashboardCancelBookingFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        }
        if (state is GymDashboardCancelBookingSuccess) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: "bookingCaceledSuccess".tr(context),
          );
        }
      },
      builder: (context, state) {
        return GeneralButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogcontext) => GeneralConfirmDialog(
                title: 'cancelBooking'.tr(context),
                cancelText: 'cancel'.tr(context),
                confirmText: 'confirm'.tr(context),
                message: 'areYouSureCancel'.tr(context),
                icon: Image.asset(Assets.assetsImagesDelete, height: 60),
                onConfirm: () async {
                  await cubit.gymCancelBooking(
                    bookingIndex: index,
                    bookingModel: gymBookingModel,
                  );
                },
                onCancel: () {},
              ),
            );
          },
          text: "cancelBooking".tr(context),
          height: 45,
          color: AppColors.red,
        );
      },
    );
  }
}
