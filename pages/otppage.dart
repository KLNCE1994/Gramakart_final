import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_select_page.dart';
import '../widgets/otp_input_widget.dart'; // 🔥 Import your widget

class OTPVerifyPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OTPVerifyPage({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_otpFocusNode);
    });
  }

  void verifyOTP() async {
    String otp = otpController.text.trim();
    if (otp.length != 6) {
      _showSnackBar('Enter a valid 6-digit OTP');
      return;
    }

    setState(() => _loading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      _showSnackBar('Logged in successfully! 🎉');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const UserSelectionPage()),
        (route) => false,
      );
    } catch (e) {
      _showSnackBar('Invalid OTP! Please try again.');
    }

    setState(() => _loading = false);
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: const Color(0xFFF9B233),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the 6-digit OTP sent to your phone',
              style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OTPInputWidget( // 🧩 Plug in the reusable OTP UI widget
              controller: otpController,
              focusNode: _otpFocusNode,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : verifyOTP,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9B233),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
