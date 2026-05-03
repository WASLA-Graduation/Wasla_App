import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.onTap,
    this.onChanged,
    this.readOnly,
    this.title,
    this.isClose,
    this.controller,
  });
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool? readOnly;
  final String? title;
  final bool? isClose;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly ?? true,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.gray.withOpacity(0.1),
        hintText: title ?? "search".tr(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        prefixIcon: IconButton(
          onPressed: () {},
          icon: Image.asset(
            Assets.assetsImagesSearch,
            width: 20,
            color: AppColors.gray,
          ),
        ),
        suffixIcon: isClose == null || isClose == true
            ? null
            : IconButton(
                onPressed: () {
                  final cubit = context.read<HomeResidentCubit>();
                  cubit.query = '';
                  controller!.clear();
                  cubit.searchInAllServiceProviders(fromPagination: false);
                },
                icon: Image.asset(
                  Assets.assetsImagesCloseIcon,
                  width: 22,
                  color: AppColors.gray,
                ),
              ),
      ),
    );
  }
}
