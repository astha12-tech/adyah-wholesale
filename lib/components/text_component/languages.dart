class LanguageHelper {
  Map<String, dynamic> data = {};
}

LanguageHelper languageHelper = LanguageHelper();

String translate(String text) {
  if (languageHelper.data.containsKey(text)) {
    return languageHelper.data[text];
  } else if (languageHelper.data.containsKey(text.toUpperCase())) {
    return languageHelper.data[text.toUpperCase()];
  } else if (languageHelper.data.containsKey(text.toLowerCase())) {
    return languageHelper.data[text.toLowerCase()];
  } else {
    return text;
  }
}
