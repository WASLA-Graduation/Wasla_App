import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/features/profile/data/models/language_model.dart';
import 'package:wasla/features/profile/presentation/widgets/lang_item.dart';

class ChangeLangList extends StatelessWidget {
  const ChangeLangList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GlobalCubit>();
    return SliverList.builder(
      itemCount: LanguageModel.languageOptions.length,
      itemBuilder: (context, index) => LangItem(
        onChanged: (val) {
          cubit.changeLanguage(locale: Locale(val ?? "en"));
        },
        languageModel: LanguageModel.languageOptions[index],
        groupValue: context.locale,
      ),
    );
  }
}
