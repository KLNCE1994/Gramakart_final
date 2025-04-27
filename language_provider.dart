// language_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageProvider with ChangeNotifier {
  Map<String, dynamic> _languageData = {};
  Locale _currentLocale = const Locale('en', 'US'); // Default locale

  Locale get currentLocale => _currentLocale;

  Future<void> loadLanguageData() async {
    try {
      String data = await rootBundle.loadString("assets/lang_data.txt");
      print(data);
      print("here we are guysch");
      _languageData = jsonDecode(data);
      setLocale(_currentLocale); // Set initial locale after loading
    } catch (e) {
      print('Error loading language data: $e');
      // Handle error appropriately
    }
  }

  void setLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners(); // Notify widgets listening to this provider
  }

  String translate(String key, BuildContext context) {
    final languageCode = _currentLocale.languageCode;
    if (_languageData.containsKey(languageCode) && _languageData[languageCode].containsKey(key)) {
      return _languageData[languageCode][key];
    }
    return key; // Fallback
  }

  // Helper function to get the translated text directly without context
  String getTranslation(String key) {
    final languageCode = _currentLocale.languageCode;
    if (_languageData.containsKey(languageCode) && _languageData[languageCode].containsKey(key)) {
      return _languageData[languageCode][key];
    }
    return key; // Fallback
  }
}