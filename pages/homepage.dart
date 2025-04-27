import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../language_provider.dart'; // Import your LanguageProvider
import '../widgets/language_dropdown.dart'; // Import the LanguageDropdown widget
import 'user_select_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _loading = false;
  bool _showOTPField = false;
  String? _verificationId;

  void _sendOTP() async {
    String phone = _phoneController.text.trim();
    if (phone.isEmpty || phone.length != 10) {
      _showSnackBar(context, context.read<LanguageProvider>().translate('Please enter a valid 10-digit phone number', context));
      return;
    }

    setState(() => _loading = true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        _showSnackBar(context, context.read<LanguageProvider>().translate('OTP Failed: ${e.message}', context));
        setState(() => _loading = false);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _showOTPField = true;
          _loading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void _verifyOTP() async {
    String otp = _otpController.text.trim();
    if (otp.length != 6) {
      _showSnackBar(context, context.read<LanguageProvider>().translate('Please enter a valid 6-digit OTP', context));
      return;
    }

    if (_verificationId == null) {
      _showSnackBar(context, context.read<LanguageProvider>().translate('Verification ID missing. Please try again.', context));
      return;
    }

    setState(() => _loading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      _showSnackBar(context, context.read<LanguageProvider>().translate('Logged in successfully! 🎉', context));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserSelectionPage()),
      );
    } catch (e) {
      _showSnackBar(context, context.read<LanguageProvider>().translate('Invalid OTP. Please try again.', context));
    }

    setState(() => _loading = false);
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 180),
                Text(
                  languageProvider.translate('GramaKart', context),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languageProvider.translate('login/signup', context),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: languageProvider.translate('Mobile number', context),
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_showOTPField)
                        TextField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          decoration: InputDecoration(
                            hintText: languageProvider.translate('OTP', context),
                            counterText: '',
                            hintStyle: const TextStyle(fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _loading
                            ? null
                            : _showOTPField
                                ? _verifyOTP
                                : _sendOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF9B233),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : Text(
                                _showOTPField
                                    ? languageProvider.translate('continue', context)
                                    : languageProvider.translate('Get otp', context),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                      const SizedBox(height: 100),
                      Text.rich(
                        TextSpan(
                          text: languageProvider.translate('By continuing, you agree to Gramakart’s', context),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: languageProvider.translate('Terms and Conditions', context),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}