import 'package:flutter/material.dart';

class SchemeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String offeredBy;
  final String mode;
  final String eligibility;
  final String schemeType;

  const SchemeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.offeredBy,
    required this.mode,
    required this.eligibility,
    required this.schemeType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 253, 248, 237),
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
      
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(
              "Offered By: $offeredBy", 
              style: const TextStyle(
                color: Colors.black,
                height: 2,
                fontSize: 14,
                )
                ),
            Text(
              "Application Mode: $mode", 
              style: const TextStyle(
                color: Colors.black,
                height: 2,
                fontSize: 14,
                )
                ),
            Text(
              "Eligibility: $eligibility", 
              style: const TextStyle(
                color: Colors.black,
                height: 2,
                fontSize: 14,
                )
                ),
            Text(
              "Scheme Type: $schemeType", 
              style: const TextStyle(
                color: Colors.black,
                height: 2,
                fontSize: 14,
                )
                ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Action goes here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  "GO",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
