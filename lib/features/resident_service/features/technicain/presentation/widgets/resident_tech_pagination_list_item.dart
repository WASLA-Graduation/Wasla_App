import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/event_type.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_image_with_stack.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/favourite/presentation/widgets/custom_bottom_sheet_romove_fav.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_list_item_desc.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/resident_technician_model.dart';

class ResidentTechPaginationListItem extends StatelessWidget {
  const ResidentTechPaginationListItem({
    super.key,
    required this.index,
    required this.technical,
    required this.withFav,
  });
  final int index;
  final bool withFav;
  final ResidentTechnicianModel technical;

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
            BuildImageWithStackWidget(imageUrl: technical.imageUrl),
            const SizedBox(width: 18),
            Expanded(
              child: BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  final cubit = context.read<FavouriteCubit>();
                  final isFav = cubit.checkFavourite(technical.id);

                  return ServiceItemDescription(
                    title: technical.name,
                    subtitle: technical.description,
                    rating: technical.rating.toDouble(),
                    isFavourite: isFav,
                    onFavouritePressed: () {
                      if (isFav) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => CustomConfirmBottomSheetRemoveFromFav(
                            content: ResidentTechPaginationListItem(
                              index: index,
                              withFav: false,
                              technical: technical,
                            ),
                            title: "remFromFav".tr(context),
                            confirmText: "rem".tr(context),
                            onConfirm: () {
                              cubit.removeFromFavorite(
                                favouriteId: cubit.getFavIdForSpecificService(
                                  technical.id,
                                ),
                                serviceProviderId: technical.id,
                              );
                            },
                          ),
                        );
                      } else {
                        cubit.addToFavourite(serviceId: technical.id);
                        context.read<HomeResidentCubit>().createUserEvent(
                          serviceProviderId: technical.id,
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
