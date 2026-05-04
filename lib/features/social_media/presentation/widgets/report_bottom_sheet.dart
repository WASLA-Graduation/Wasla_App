import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/social_enums.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/social_media/presentation/widgets/custom_choose_report_bottom_sheet.dart';

class ReportBottomSheet extends StatelessWidget {
  const ReportBottomSheet({
    super.key,
    required this.content,
    required this.targetId,
    required this.targetType,
  });
  final String content;
  final int targetId;
  final TargetType targetType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
          InkWell(
            onTap: () {
              // context.pushScreen(
              //   AppRoutes.socialReportScreen,
              //   arguments: {
              //     AppStrings.targetId: targetId,
              //     AppStrings.targetType: targetType,
              //   },
              // );

              context.pop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.4,
                    maxChildSize: 0.9,
                    expand: false,
                    builder: (_, controller) {
                      return CustomChooseReportBottomSheet(
                        content: content,
                        targetId: targetId,
                        targetType: targetType,
                      );
                    },
                  );
                },
              );
            },
            child: Row(
              children: [
                Icon(Icons.report_outlined, color: AppColors.red, size: 26),
                const SizedBox(width: 15),
                Text(
                  'report'.tr(context),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),

          const SizedBox(),
        ],
      ),
    );
  }
}
