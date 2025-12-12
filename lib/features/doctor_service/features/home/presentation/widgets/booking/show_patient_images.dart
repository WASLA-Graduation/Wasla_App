import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';

class ShowPatientImagesWidget extends StatelessWidget {
  const ShowPatientImagesWidget({super.key, required this.model});

  final DoctorBookingModel model;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();


    print("*************************************");
    print("*************************************");
    print("*****************${model.bookingImages.first}**************");
    print("*************************************");
    print("*************************************");
    return Column(
      spacing: 15,
      children: [
        Visibility(
          visible: cubit.bookingWithImagesIds.contains(model.bookingId),
          child: InkWell(
            onTap: () {
              cubit.toggleShowPatientImages(model.bookingId);
            },
            child: Text(
              cubit.showPatientImages.contains(model.bookingId)
                  ? "hideImages".tr(context)
                  : "showImages".tr(context),

              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),

        Visibility(
          visible: cubit.showPatientImages.contains(model.bookingId),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children: List.generate(
                model.bookingImages.length,
                (index) => ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => ImageDialogWidget(
                          image: model.bookingImages[index],
                        ),
                      );
                    },
                    child: CustomCachedNetworkImage(
                      imageUrl: model.bookingImages[index],
                      width: 70,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageDialogWidget extends StatelessWidget {
  const ImageDialogWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: double.maxFinite,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CustomCachedNetworkImage(imageUrl: image),
        ),
      ),
    );
  }
}
