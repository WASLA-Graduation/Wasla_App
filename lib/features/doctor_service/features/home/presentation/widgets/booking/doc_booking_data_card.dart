import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/functions/localizedDays.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/widgets/general_confirmation_widget.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/show_patient_images.dart';

class DocBookingDataCard extends StatelessWidget {
  const DocBookingDataCard({
    super.key,
    required this.model,
    required this.index,
  });
  final DoctorBookingModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          ClipOval(
            child: CustomCachedNetworkImage(
              imageUrl: model.userImage,
              width: 70,
            ),
          ),
          _buildTextWidget(
            context,
            title: "patientName".tr(context),
            value: model.userName,
          ),
          _buildTextWidget(
            context,
            title: "phone".tr(context),
            value: model.phone,
          ),
          _buildTextWidget(
            context,
            title: "serviceName".tr(context),
            value: model.serviceName,
          ),
          _buildTextWidget(
            context,
            title: "bookingType".tr(context),
            value: model.bookingType == 1
                ? "examination".tr(context)
                : "consultation".tr(context),
          ),
          _buildTextWidget(
            context,
            title: "day".tr(context),
            value: localizedDays(index: model.day),
          ),
          _buildTextWidget(
            context,
            title: "date".tr(context),
            value: model.date,
          ),
          _buildTextWidget(
            context,
            title: "time".tr(context),
            value:
                "${convertBackendTimeToAmPm(model.start)} ${"to".tr(context)} ${convertBackendTimeToAmPm(model.end)}",
          ),
          _buildTextWidget(
            context,
            title: "price".tr(context),
            value: "${model.price} ${"egb".tr(context)}",
          ),
          const SizedBox(height: 3),

          context.read<DoctorHomeCubit>().bookingStatus == 1
              ? Column(
                  spacing: 10,
                  children: [
                    GeneralButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogcontext) => GeneralConfirmDialog(
                            title: 'cancelBooking'.tr(context),
                            cancelText: 'cancel'.tr(context),
                            confirmText: 'confirm'.tr(context),
                            message: 'areYouSureCancel'.tr(context),
                            icon: Image.asset(
                              Assets.assetsImagesDelete,
                              height: 60,
                            ),
                            onConfirm: () async {
                              await context
                                  .read<DoctorHomeCubit>()
                                  .cancelBooking(
                                    bookingId: model.bookingId,
                                    index: index,
                                  );
                            },
                            onCancel: () {},
                          ),
                        );
                      },
                      text: "cancelBooking".tr(context),
                      height: 45,
                      color: AppColors.red,
                    ),
                    GeneralButton(
                      onPressed: () {
                        context.pushScreen(
                          AppRoutes.doctorEditBookingScreen,
                          arguments: model,
                        );
                      },
                      text: "editBooking".tr(context),
                      height: 45,
                    ),
                  ],
                )
              : const SizedBox(),

          ShowPatientImagesWidget(model: model),
        ],
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
