import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart'; // Adjust the import path based on your file structure

/// A reusable custom app bar widget with logo, title, and language option.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end, // Align bottom
            children: [
              // Left: Logo + Gramakart
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10), // Pushes image a bit down
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50, // Adjust this as needed
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 0),
                   Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      languageProvider.translate('GramaKart',context),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              // Right: Language Dropdown
              const LanguageDropdownInAppBar(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class LanguageDropdownInAppBar extends StatefulWidget {
  const LanguageDropdownInAppBar({super.key});

  @override
  State<LanguageDropdownInAppBar> createState() => _LanguageDropdownInAppBarState();
}

class _LanguageDropdownInAppBarState extends State<LanguageDropdownInAppBar> {
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
      padding: const EdgeInsets.only(right: 4.0, bottom: 2), // Adjust bottom padding to align
      child: DropdownButton<String>(
        value: _selectedLanguage,
        hint: Row(
          children: [
            const Icon(Icons.language_outlined, color: Colors.black),
            const SizedBox(width: 1),
            Text(
              languageProvider.translate('Language', context), // You might want a more specific key
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          ],
        ),
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
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 25,
        iconEnabledColor: Colors.black,
        underline: const SizedBox(), // Remove the underline
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }
}