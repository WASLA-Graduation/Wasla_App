import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_bottom_sheet_romove_fav.dart';

class DoctorListItemDescriptionWidget extends StatelessWidget {
  const DoctorListItemDescriptionWidget({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        Divider(height: 20, color: AppColors.primaryColor, thickness: .1),
        _buildSpecialityWidget(context),
        const SizedBox(height: 10),
        _buildReviwesWidget(context),
      ],
    );
  }

  Text _buildSpecialityWidget(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.clip,
      "${doctor.specialtyName} | ${doctor.hospitalname}",
      style: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
    );
  }

  Row _buildTitleWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            doctor.fullName,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 10),
        withoutFav == null || withoutFav == false
            ? BlocBuilder<DoctorCubit, DoctorState>(
                builder: (context, state) {
                  final cubit = context.read<DoctorCubit>();
                  return InkWell(
                    onTap: () {
                      if (cubit.favouriteDocs[index]) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => CustomBottomSheetRemoveFav(
                            index: index,
                            doctor: doctor,
                          ),
                        );
                      } else {
                        cubit.toggleFavouriteIcon(index: index);
                      }
                    },
                    child: Image.asset(
                      cubit.favouriteDocs[index]
                          ? Assets.assetsImagesFavourite
                          : Assets.assetsImagesHeartOutline,
                      width: 20,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              )
            : SizedBox(),
      ],
    );
  }

  Row _buildReviwesWidget(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.primaryColor, size: 18),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "4.5  (4,577 reviwes)",
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
      ],
    );
  }

  String fixHospital(String? word) {
    final w = (word ?? "").trim();
    if (w.isEmpty) return "hospital";
    if (w.toLowerCase().contains("hospital")) {
      return w;
    }
    return "$w hospital";
  }
}
