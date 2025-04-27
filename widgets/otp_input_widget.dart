import 'package:flutter/material.dart';

class OTPInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const OTPInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
        hintText: 'Enter OTP',
        counterText: '',
        hintStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
