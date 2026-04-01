import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/profile/presentation/widgets/change_lang_list.dart';

class ChangeLangBody extends StatelessWidget {
  const ChangeLangBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              "suggested".tr(context),
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),

          ChangeLangList(),
        ],
      ),
    );
  }
}
