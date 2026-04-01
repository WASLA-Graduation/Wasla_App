import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_image_with_stack.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/favourite/presentation/widgets/custom_bottom_sheet_romove_fav.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_list_item_desc.dart';
import 'package:wasla/features/resident_service/features/gym/data/models/gym_data_model.dart';

class ResidentGymItem extends StatelessWidget {
  const ResidentGymItem({
    super.key,
    required this.index,
    this.withoutFav,
    required this.gym,
  });
  final int index;
  final bool? withoutFav;
  final GymDataModel gym;

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
            BuildImageWithStackWidget(imageUrl: gym.imageUrl),
            const SizedBox(width: 18),
            Expanded(
              child: BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  final cubit = context.read<FavouriteCubit>();
                  final isFav = cubit.checkFavourite(gym.id);

                  return ServiceItemDescription(
                    title: gym.name,
                    subtitle: gym.description,
                    rating: gym.rating.toDouble(),
                    isFavourite: isFav,
                    onFavouritePressed: () {
                      if (isFav) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => CustomConfirmBottomSheetRemoveFromFav(
                            content: ResidentGymItem(
                              index: index,
                              withoutFav: true,
                              gym: gym,
                            ),
                            title: "Remove from favourite?",
                            confirmText: "Yes, Remove",
                            onConfirm: () {
                              cubit.removeFromFavorite(
                                favouriteId: cubit.getFavIdForSpecificService(
                                  gym.id,
                                ),
                                serviceProviderId: gym.id,
                              );
                            },
                          ),
                        );
                      } else {
                        cubit.addToFavourite(serviceId: gym.id);
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
