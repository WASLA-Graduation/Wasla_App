import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/event_type.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_image_with_stack.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/favourite/presentation/widgets/custom_bottom_sheet_romove_fav.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_list_item_desc.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class DoctorListItem extends StatelessWidget {
  const DoctorListItem({
    super.key,
    required this.index,
    this.withoutFav,
    required this.doctor,
  });
  final int index;
  final bool? withoutFav;
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: doctor.imageUrl,
              child: BuildImageWithStackWidget(imageUrl: doctor.imageUrl),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  final cubit = context.read<FavouriteCubit>();
                  final isFav = cubit.checkFavourite(doctor.id);

                  return ServiceItemDescription(
                    title: doctor.fullName,
                    subtitle:
                        "${doctor.specialtyName} | ${doctor.hospitalname}",
                    rating: doctor.rating,
                    isFavourite: isFav,
                    onFavouritePressed: () {
                      if (isFav) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => CustomConfirmBottomSheetRemoveFromFav(
                            content: DoctorListItem(
                              index: index,
                              withoutFav: true,
                              doctor: doctor,
                            ),
                            title: "Remove from favourite?",
                            confirmText: "Yes, Remove",
                            onConfirm: () {
                              cubit.removeFromFavorite(
                                favouriteId: cubit.getFavIdForSpecificService(
                                  doctor.id,
                                ),
                                serviceProviderId: doctor.id,
                              );
                            },
                          ),
                        );
                      } else {
                        cubit.addToFavourite(serviceId: doctor.id);
                        context.read<HomeResidentCubit>().createUserEvent(
                          serviceProviderId: doctor.id,
                          eventType: EventType.addToFavorites,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
