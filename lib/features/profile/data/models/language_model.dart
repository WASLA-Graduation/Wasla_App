class LanguageModel {
  final String langCode;
  final String langName;

  const LanguageModel({required this.langCode, required this.langName});

  static const List<LanguageModel> languageOptions = [
    LanguageModel(langCode: 'en', langName: 'english'),
    LanguageModel(langCode: 'ar', langName: 'arabic'),
  ];
}
