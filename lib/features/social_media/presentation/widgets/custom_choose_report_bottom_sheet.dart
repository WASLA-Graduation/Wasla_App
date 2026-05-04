import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/report_enum.dart';
import 'package:wasla/core/enums/social_enums.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_radio_button_list.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';

class CustomChooseReportBottomSheet extends StatelessWidget {
  const CustomChooseReportBottomSheet({
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
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),

      child: Column(
        children: [
          UnderLineWidget(),
          const SizedBox(height: 10),
          Text(
            "report".tr(context),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(color: Colors.red),
          ),

          Divider(thickness: 0.3, height: 20),
          Text(
            "reportDesc".tr(context),
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),

          BlocBuilder<SocialMediaCubit, SocialMediaState>(
            builder: (context, state) {
              final cubit = context.read<SocialMediaCubit>();
              return CustomRadioList<ReportReason>(
                values: ReportReason.values
                    .where((e) => e != ReportReason.none)
                    .toList(),
                groupValue: cubit.reportReason,
                onChanged: (value) {
                  cubit.chooseReport(reportReason: value);
                },
                titleBuilder: (value) {
                  return value.name.tr(context);
                },
              );
            },
          ),

          const SizedBox(height: 10),
          BlocBuilder<SocialMediaCubit, SocialMediaState>(
            builder: (context, state) {
              return _buildButtons(
                context,
                onConfirm: () {
                  Navigator.pop(context);
                  context.read<SocialMediaCubit>().reportForSomething(
                    targetId: targetId,
                    targetType: targetType,
                    reason: context
                        .read<SocialMediaCubit>()
                        .reportReason
                        .name
                        .tr(context),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Row _buildButtons(BuildContext context, {required VoidCallback onConfirm}) {
    return Row(
      children: [
        Expanded(
          child: GeneralButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<SocialMediaCubit>().reportReason = ReportReason.none;
            },
            text: 'cancel'.tr(context),
            height: 45,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: GeneralButton(
            color:
                context.read<SocialMediaCubit>().reportReason ==
                    ReportReason.none
                ? Colors.grey
                : AppColors.primaryColor,
            onPressed: onConfirm,
            text: 'reportWord'.tr(context),
            height: 45,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
