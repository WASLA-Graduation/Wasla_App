import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    this.hint,
    this.onSelecte,
    this.initialSelection,
  });

  final List<DropDownItem> items;
  final String? hint;
  final String? initialSelection;
  final void Function(String?)? onSelecte;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: double.infinity,
      onSelected: onSelecte,
      hintText: hint,
      initialSelection: initialSelection,
      textStyle: Theme.of(context).textTheme.headlineMedium,
      inputDecorationTheme: _buildInputDecoration(context),
      menuStyle: _buildMenuStyle(context),
      dropdownMenuEntries: items.map((item) {
        return _buildItems(item, context);
      }).toList(),
    );
  }

  DropdownMenuEntry<String> _buildItems(
    DropDownItem item,
    BuildContext context,
  ) {
    return DropdownMenuEntry<String>(
      value: item.value,
      label: item.label,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        foregroundColor: WidgetStateProperty.all(
          context.isDarkMode ? Colors.grey.shade400 : Colors.black,
        ),
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
      fillColor: AppColors.gray.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }

  MenuStyle _buildMenuStyle(BuildContext context) {
    return MenuStyle(
      maximumSize: WidgetStateProperty.all(
        const Size(double.infinity, double.maxFinite),
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
