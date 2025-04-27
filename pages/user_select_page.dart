// user_select_page seller/customer

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart'; // Import your LanguageProvider
import '../widgets/language_dropdown.dart'; 

class UserSelectionPage extends StatelessWidget {
  const UserSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          LanguageDropdown(), // Add the language dropdown here
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with reduced bottom spacing
              // Logo with tight spacing

              // Wrapping in ClipRect to cut invisible space
              ClipRect(
                child: SizedBox(
                  height: 180, 
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fitHeight, 
                    ),
                  ),
                ),
              ),

              // Title
               Text(
                languageProvider.translate('GramaKart', context),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),



              const SizedBox(height: 40),

              // Cards Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionCard(
                    context,
                    label: languageProvider.translate("Business", context),
                    imagePath: 'assets/images/business.jpg',
                    onPressed: () {
                      Navigator.pushNamed(context, '/businesslogin');
                    },
                  ),
                  _buildOptionCard(
                    context,
                    label: languageProvider.translate('Consumer', context),
                    imagePath: 'assets/images/consumer.jpg',
                    onPressed: () {
                      Navigator.pushNamed(context, '/customerprofilesetup');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Option Card Builder
  Widget _buildOptionCard(
    
    BuildContext context, {
    required String label,
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      children: [
        Container(
          width: 160,
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 210, // Do not change for Sanjay's phone
                //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color.fromARGB(225, 225, 184, 0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      imagePath,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB800),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onPressed,
                        child:  Text(
                          languageProvider.translate('Continue',context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
