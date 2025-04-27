import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SeeMoreButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "See More",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
