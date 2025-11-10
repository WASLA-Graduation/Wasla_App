import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';

import 'package:wasla/core/utils/app_styles.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    this.hint,
    this.onSelecte,
  });

  final List<String> items;
  final String? hint;
  final void Function(String?)? onSelecte;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: double.infinity,
      onSelected: onSelecte,
      hintText: hint,
      textStyle: AppStyles.styleMeduim20(context),
      inputDecorationTheme: _buildInputDecoration(context),
      menuStyle: _buitldMenuStyle(context),
      dropdownMenuEntries: items.map((item) {
        return _buildItems(item, context);
      }).toList(),
    );
  }

  DropdownMenuEntry<String> _buildItems(String item, BuildContext context) {
    return DropdownMenuEntry<String>(
      value: item,
      label: item,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        foregroundColor: WidgetStateProperty.all(Colors.grey.shade400),
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  InputDecorationTheme _buildInputDecoration(BuildContext context) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor:AppColors.gray.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }

  MenuStyle _buitldMenuStyle(BuildContext context) {
    return MenuStyle(
      maximumSize: WidgetStateProperty.all(
        Size(double.infinity, double.maxFinite),
      ),
      backgroundColor: WidgetStateProperty.all(
        context.isDarkMode ? Colors.grey.shade800 : Colors.white,
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
