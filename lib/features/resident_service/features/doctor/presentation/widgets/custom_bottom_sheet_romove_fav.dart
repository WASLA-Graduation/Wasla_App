import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_list_item.dart';

class CustomBottomSheetRemoveFav extends StatelessWidget {
  const CustomBottomSheetRemoveFav({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      height: SizeConfig.blockHeight * 40,
      decoration: BoxDecoration(
        color: AppColors.lightbackgroundColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        spacing: 13,
        children: [
          _buildUnderLineWidget(),
          _buildTextWidget(context),
          const SizedBox(),
          DoctorListItem(index: index),
          const Spacer(),
          _buildButtons(context),
        ],
      ),
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
          children: [
            Expanded(
              child: GeneralButton(
                onPressed: () {
                  context.popScreen();
                },
                text: "Cancel",
                height: 45,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: GeneralButton(
                onPressed: () {
                  context.read<DoctorCubit>().toggleFavouriteIcon(
                    index: index,
                  );
                  context.popScreen();
                },
                text: "Yes , Remove",
                height: 45,
                fontSize: 15,
              ),
            ),
          ],
        );
  }

  Text _buildTextWidget(BuildContext context) => Text(
    "Remove from favourite ?",
    style: Theme.of(context).textTheme.headlineMedium,
  );

  Container _buildUnderLineWidget() {
    return Container(
      width: 50,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.grayDark,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
