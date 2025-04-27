import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart'; // Adjust the import path based on your file structure

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = Provider.of<LanguageProvider>(context, listen: false).currentLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: DropdownButton<String>(
        value: _selectedLanguage,
        hint: Text(languageProvider.translate('Language', context)), // Initial hint
        items: const [
          DropdownMenuItem(
            value: 'en',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'ta',
            child: Text('Tamil'),
          ),
          DropdownMenuItem(
            value: 'hi',
            child: Text('Hindi'),
          ),
        ],
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
            Locale newLocale;
            switch (newValue) {
              case 'en':
                newLocale = const Locale('en', 'US');
                break;
              case 'ta':
                newLocale = const Locale('ta', 'IN');
                break;
              case 'hi':
                newLocale = const Locale('hi', 'IN');
                break;
              default:
                newLocale = languageProvider.currentLocale; // Keep current if unknown
            }
            Provider.of<LanguageProvider>(context, listen: false).setLocale(newLocale);
          }
        },
      ),
    );
  }
}