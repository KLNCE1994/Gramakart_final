// schemes page for sellers (sry for spelling mistake in the file name dude)
import 'package:flutter/material.dart';
import 'package:newapp/pages/salesprofile.dart';
import 'package:newapp/pages/salespage.dart';
import 'package:newapp/widgets/seller_navbar.dart';
import 'package:newapp/widgets/scheme_card.dart';
import 'package:newapp/backend.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../language_provider.dart';


class SchemesPages extends StatefulWidget {
  final String docId;
  const SchemesPages({super.key, required this.docId});

  @override
  State<SchemesPages> createState() => _SchemesPagesState();
}

class _SchemesPagesState extends State<SchemesPages> {
  int _selectedIndex = 0;
  Map<String, dynamic>? businessProfile; // store profile here
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadBusinessProfile(); // Call backend function here
  }

  Future<void> _loadBusinessProfile() async {
    try {
      final profile = await Backend.fetchBusinessProfile(widget.docId);
      setState(() {
        businessProfile = profile;
        isLoading = false;
      });
      debugPrint('Fetched profile: $profile');
    } catch (e) {
      debugPrint('Error loading profile: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // ignore: unused_element
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });
    

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SalesPages(docId: widget.docId)),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  SalesProfiles(docId: widget.docId)),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
         Padding(padding: const EdgeInsets.only(top:18),
          child:  Row(
             children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile.png'),
                backgroundColor: Colors.white,
              ),
               const SizedBox(width: 0),
               Text(
                 isLoading
                  ? 'Loading...'
                  : (businessProfile?['businessName'] ?? 'Business Name'),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),),
          const SizedBox(height: 20),
           Text(
            languageProvider.translate('Eligible Schemes',context),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const SchemeCard(
            imagePath: 'assets/images/sch1.png',
            title: 'Pradan Mantri Mudhra Yojana',
            offeredBy: 'Central Govt.',
            mode: 'Online/Offline through Bank',
            eligibility: 'Women | SC/ST | Rural | Minority',
            schemeType: 'Loan / Financial Inclusive Scheme',
          ),
          const SizedBox(height: 16),
          const SchemeCard(
            imagePath: 'assets/images/sch1.png',
            title: 'Pradan Mantri Mudhra Yojana',
            offeredBy: 'Central Govt.',
            mode: 'Online/Offline through Bank',
            eligibility: 'Women | SC/ST | Rural | Minority',
            schemeType: 'Loan / Financial Inclusive Scheme',
          ),
        ],

      ),
    );
  }
}
