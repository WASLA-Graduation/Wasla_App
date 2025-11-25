import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
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
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          UnderLineWidget(),
          _buildTextWidget(context),
          const SizedBox(),
          DoctorListItem(index: index, withoutFav: true),
          _buildButtons(context),
          const SizedBox(),
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
              context.read<DoctorCubit>().toggleFavouriteIcon(index: index);
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
}
