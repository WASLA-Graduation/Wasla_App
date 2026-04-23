import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';

class DeleteUpdateBottomSheet extends StatelessWidget {
  const DeleteUpdateBottomSheet({
    super.key,
    this.onEdit,
    this.onDelete,
    this.showEdit = true,
    this.showDelete = true,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showEdit;
  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          UnderLineWidget(),

          if (showEdit)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onEdit?.call();
              },
              leading: const Icon(Icons.edit),
              title: Text("edit".tr(context)),
            ),

          if (showDelete)
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onDelete?.call();
              },
              leading: const Icon(Icons.delete),
              title: Text("delete".tr(context)),
            ),
        ],
      ),
    );
  }
}
