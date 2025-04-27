// lib/widgets/business_card.dart
import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final String name;
  final String category;
  final String location;
  final String imagePath;

  const BusinessCard({
    super.key,
    required this.name,
    required this.category,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage(imagePath),
              backgroundColor: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 5),
          Text(name,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 17, height: 2)),
          Text("Category: $category",
              style: const TextStyle(fontSize: 14, height: 2, color: Color.fromARGB(255, 56, 56, 56))),
          Text("Location: $location", style: const TextStyle(fontSize: 14,color: Color.fromARGB(255, 56, 56, 56))),
          const SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text(
                "Explore",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
