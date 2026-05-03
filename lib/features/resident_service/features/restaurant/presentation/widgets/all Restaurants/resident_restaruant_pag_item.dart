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
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class ResidentRestaruantPagItem extends StatelessWidget {
  const ResidentRestaruantPagItem({
    super.key,
    required this.withFav,
    required this.index,
    required this.restaurant,
  });

  final bool withFav;
  final int index;
  final RestaurantModel restaurant;

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
            BuildImageWithStackWidget(imageUrl: restaurant.gallery.first),
            const SizedBox(width: 18),
            Expanded(
              child: BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  final cubit = context.read<FavouriteCubit>();
                  final isFav = cubit.checkFavourite(restaurant.id);

                  return ServiceItemDescription(
                    title: restaurant.name,
                    subtitle: restaurant.description,
                    rating: 4.7,
                    isFavourite: isFav,
                    onFavouritePressed: () {
                      if (isFav) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => CustomConfirmBottomSheetRemoveFromFav(
                            content: ResidentRestaruantPagItem(
                              index: index,
                              withFav: false,
                              restaurant: restaurant,
                            ),
                            title: "remFromFav".tr(context),
                            confirmText: "rem".tr(context),
                            onConfirm: () {
                              cubit.removeFromFavorite(
                                favouriteId: cubit.getFavIdForSpecificService(
                                  restaurant.id,
                                ),
                                serviceProviderId: restaurant.id,
                              );
                            },
                          ),
                        );
                      } else {
                        cubit.addToFavourite(serviceId: restaurant.id);
                          context.read<HomeResidentCubit>().createUserEvent(
                          serviceProviderId: restaurant.id,
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
