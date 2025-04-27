import 'package:flutter/material.dart';

/// A reusable custom app bar widget with logo, search bar, and language option.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const CustomAppBar({super.key, this.height = 80});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 10),

              // Search Bar - slightly pushed down and aligned well
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10), // move it down
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0, // centers the text
                          horizontal: 16,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: Icon(Icons.search, size: 25),
                        ),
                      ),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Language icon + English
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Icon(Icons.language_outlined, color: Colors.black),
                  ),
                  SizedBox(width: 2),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16, right: 8),
                    child: Text(
                      'English',
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
