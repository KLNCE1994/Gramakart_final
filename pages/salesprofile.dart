import 'package:flutter/material.dart';
import 'package:newapp/widgets/seller_navbar.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../language_provider.dart'; // Import your LanguageProvider
//import '../widgets/language_dropdown.dart'; 
import '../backend.dart'; // Ensure the path is correct

class SalesProfiles extends StatefulWidget {
  final String docId;
  const SalesProfiles({super.key, required this.docId});

  @override
  State<SalesProfiles> createState() => _SalesProfilesState();
}

class _SalesProfilesState extends State<SalesProfiles> {
  String? businessName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBusinessProfile();
  }

  Future<void> loadBusinessProfile() async {
    try {
      final data = await Backend.fetchBusinessProfile(widget.docId);
      setState(() {
        businessName = data['businessName'] ?? 'Unnamed Seller';
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching business profile: $e");
      setState(() {
        businessName = 'Error loading name';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          businessName ?? '',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(languageProvider.translate("Account Settings", context), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  _buildSettingItem(Icons.shopping_bag, "My Orders"),
                  _buildSettingItem(Icons.edit, "Change Username"),
                  _buildSettingItem(Icons.location_on, "Change Address"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String text) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(languageProvider.translate(text,context)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        // Add navigation if needed
      },
    );
  }
}
