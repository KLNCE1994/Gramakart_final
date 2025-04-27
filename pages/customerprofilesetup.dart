// customer profile setup (name and pincode)

import 'package:flutter/material.dart';
import 'customerhome.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../language_provider.dart'; // Import your LanguageProvider
import '../widgets/language_dropdown.dart'; 
class ConsumerProfilesetup extends StatelessWidget {
  const ConsumerProfilesetup({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider =  Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          LanguageDropdown(), // Add the language dropdown here
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/logo.png', // Ensure image path matches your asset
                        height: 100,
                      ),
                      const SizedBox(height: 10),

                      // Title
                       Text(
                        languageProvider.translate('GramaKart',context),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),

                       Text(
                        languageProvider.translate('Welcome!\nShop the Soul of India.',context),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                       Text(
                        languageProvider.translate("Consumer Profile", context),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name field
                      TextField(
                        decoration: InputDecoration(
                          hintText: languageProvider.translate("Name", context),
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Pincode field
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: languageProvider.translate("Pincode", context),
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Continue Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CustomerHomePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF9B233),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:  Text(
                          languageProvider.translate('Continue',context),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Terms and Conditions
                 Text.rich(
                  TextSpan(
                    text: languageProvider.translate("By continuing, you agree to Gramakart’s", context),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: languageProvider.translate('Terms and Conditions',context),
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
