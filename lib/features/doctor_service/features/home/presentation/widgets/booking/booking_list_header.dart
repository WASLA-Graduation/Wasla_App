import 'package:flutter/material.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';

class CustomListHeader extends StatelessWidget {
  const CustomListHeader({
    super.key,
    required this.title,
    required this.hint,
    required this.initialValue,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final String hint;
  final String? initialValue;
  final List<DropDownItem> items;
  final Future<void> Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 20),
        CustomDropDownMenu(
          hint: hint,
          initialSelection: initialValue,
          items: items,
          onSelecte: onChanged,
        ),
      ],
    );
  }
}
