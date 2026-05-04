import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_sizes.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections(context);

    return Scaffold(
      appBar: AppBar(title: Text("privacyPolicy".tr(context))),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.marginDefault,
          vertical: AppSizes.paddingSizeSmall,
        ),
        itemCount: sections.length,
        separatorBuilder: (_, __) =>
            SizedBox(height: AppSizes.paddingSizeSmall),
        itemBuilder: (context, index) => PolicySection(
          title: sections[index].title,
          body: sections[index].body,
        ),
      ),
    );
  }

  List<_SectionData> _buildSections(BuildContext context) {
    return [
      _SectionData(
        title: "typesOfDataWeCollect".tr(context),
        body: "typesOfDataWeCollectBody".tr(context),
      ),
      _SectionData(
        title: "useOfYourPersonalData".tr(context),
        body: "useOfYourPersonalDataBody".tr(context),
      ),
      _SectionData(
        title: "disclosureOfYourPersonalData".tr(context),
        body: "disclosureOfYourPersonalDataBody".tr(context),
      ),
    ];
  }
}

class _SectionData {
  final String title;
  final String body;
  const _SectionData({required this.title, required this.body});
}

class PolicySection extends StatelessWidget {
  const PolicySection({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSizes.paddingSizeExtraSmall),
        Text(
          body,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: theme.colorScheme.onSurface.withOpacity(0.75),
          ),
        ),
      ],
    );
  }
}
