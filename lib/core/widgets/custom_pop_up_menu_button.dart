import 'package:flutter/material.dart';

class CustomPopupMenu<T> extends StatelessWidget {
  const CustomPopupMenu({
    super.key,
    required this.child,
    required this.items,
    required this.onSelected,
  });

  final Widget child;
  final List<PopupMenuEntry<T>> items;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      padding: EdgeInsets.zero,
      splashRadius: 20,
      elevation: 8,
      onSelected: onSelected,
      itemBuilder: (context) => items,
      child: child,
    );
  }
}
