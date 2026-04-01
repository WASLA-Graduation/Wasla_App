import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/profile/data/models/language_model.dart';

class LangItem extends StatelessWidget {
  const LangItem({
    super.key,
    required this.languageModel,
    required this.groupValue,
    required this.onChanged,
  });
  final LanguageModel languageModel;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        languageModel.langName.tr(context),
        style: Theme.of(
          context,
        ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: Radio(
        value: languageModel.langCode,
        groupValue: groupValue,
        onChanged: onChanged,
        side: const BorderSide(color: AppColors.primaryColor),
      ),
    );
  }
}
