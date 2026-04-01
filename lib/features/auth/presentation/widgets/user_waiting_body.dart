import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/custom_lable_sub_lable_widget.dart';

class UserWaitingBody extends StatelessWidget {
  const UserWaitingBody({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });
  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            image,
            width: SizeConfig.screenWidth * 0.4,
            height: SizeConfig.screenWidth * 0.4,
          ),
        ),
        const VerticalSpace(height: 5),
        CustomLableSubLableWidget(
          title: title.tr(context),
          subTitle: subTitle.tr(context),
        ),
      ],
    );
  }
}
