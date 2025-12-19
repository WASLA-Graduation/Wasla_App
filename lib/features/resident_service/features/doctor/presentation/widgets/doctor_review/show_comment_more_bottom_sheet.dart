import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/review_action.dart';
import 'package:wasla/core/models/review_bottom_sheet_model.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ShowCommentMoreBottomSheet extends StatelessWidget {
  const ShowCommentMoreBottomSheet({
    super.key,
    required this.onActionSelected,
    required this.canDelete,
  });

  final void Function(ReviewAction action) onActionSelected;
  final bool canDelete;

  @override
  Widget build(BuildContext context) {
    final options = ReviewBottomSheetModel.commentOptions.where((item) {
      if (item.action == ReviewAction.delete) {
        return canDelete;
      }
      return true;
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options.map((item) {
        return ListTile(
          onTap: () {
            Navigator.pop(context);
            onActionSelected(item.action);
          },
          leading: Icon(item.icon, color: AppColors.primaryColor),
          title: Text(
            item.title.tr(context),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        );
      }).toList(),
    );
  }
}
