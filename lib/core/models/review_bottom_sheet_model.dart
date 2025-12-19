import 'package:flutter/material.dart';
import 'package:wasla/core/enums/review_action.dart';

class ReviewBottomSheetModel {
  final ReviewAction action;
  final String title;
  final IconData icon;

  const ReviewBottomSheetModel({
    required this.action,
    required this.title,
    required this.icon,
  });

  static const List<ReviewBottomSheetModel> commentOptions = [
    ReviewBottomSheetModel(
      action: ReviewAction.edit,
      title: 'edit',
      icon: Icons.edit_outlined,
    ),
    ReviewBottomSheetModel(
      action: ReviewAction.delete,
      title: 'delete',
      icon: Icons.delete_outline,
    ),
    ReviewBottomSheetModel(
      action: ReviewAction.copy,
      title: 'copy',
      icon: Icons.content_copy,
    ),
  ];
}
