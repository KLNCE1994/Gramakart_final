//businesss profile setup page 2 for image input

import 'dart:io';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/backend.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart'; // Import your LanguageProvider
import '../widgets/language_dropdown.dart'; 


class BusinessProfileSetupPage extends StatefulWidget {
  final String docId;

  const BusinessProfileSetupPage({super.key, required this.docId});
  

  @override
  State<BusinessProfileSetupPage> createState() =>
      _BusinessProfileSetupPageState();
}

class _BusinessProfileSetupPageState extends State<BusinessProfileSetupPage> {
  File? _profileImage;
  Uint8List? _webImage;
  String? _selectedRole;
  String? _selectedGender;
  

bool get _canContinue =>
    _selectedRole != null && _selectedGender != null;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        if (kIsWeb) {
          final imageBytes = await pickedImage.readAsBytes();
          setState(() {
            _webImage = imageBytes;
            _profileImage = null;
          });
        } else {
          setState(() {
            _profileImage = File(pickedImage.path);
            _webImage = null;
          });
        }
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

    Future<void> _submitProfileData() async {
      try{
        final response = await Backend.sendBusinessProfile2(
          docId: widget.docId,
          pic: _profileImage,
          webPic: _webImage,
          role: _selectedRole!,
          gender: _selectedGender!,
        );

        if(response['success']==true){
          print('Data posted');
          _onContinuePressed();

        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed")),
          );
        }
      }
      catch(e){
        print("error occured: $e");
      }
    }

  void _onContinuePressed() {
    // Navigate to the SalesPage and pass the profile image
    Navigator.pushNamed(context, '/sales', arguments: widget.docId);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          LanguageDropdown(), // Add the language dropdown here
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width > 400
                    ? 24
                    : 16, // Dynamic margin
                vertical: 40,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(padding: const EdgeInsets.only(top:15),
                            child: Text(
                              languageProvider.translate('GramaKart',context),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),
                            const SizedBox(height: 2),
                            Text(
                              languageProvider.translate("Your Craft, Our Platform - Grow with Confidence.",context),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                   Text(
                    languageProvider.translate('Business Profile',context),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      languageProvider.translate('Choose a Profile Photo', context),
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.3, // Responsive width
                      height: MediaQuery.of(context).size.width *
                          0.3, // Keep it square
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : _webImage != null
                                ? MemoryImage(_webImage!)
                                : null,
                        child: _profileImage == null && _webImage == null
                            ? const Icon(Icons.person,
                                size: 50, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

// Role Dropdown
const Align(
  alignment: Alignment.centerLeft,
 
),
const SizedBox(height: 10),
DropdownButtonFormField<String>(
  value: _selectedRole,
  hint:  Text(
    languageProvider.translate('Select your role',context)
    ),
  items: [languageProvider.translate('Farmer', context), languageProvider.translate('Artisian', context), languageProvider.translate('Retailer', context)]
      .map((role) => DropdownMenuItem(
            value: role,
            child: Text(role),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      _selectedRole = value;
    });
  },
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  ),
),

const SizedBox(height: 20),

// Gender Dropdown
const Align(
  alignment: Alignment.centerLeft,

),
const SizedBox(height: 10),
DropdownButtonFormField<String>(
  value: _selectedGender,
  hint:  Text(languageProvider.translate('Select your gender',context)),
  items: [languageProvider.translate('Male', context),languageProvider.translate('Female', context) , languageProvider.translate('Transgender', context)]
      .map((gender) => DropdownMenuItem(
            value: gender,
            child: Text(gender),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      _selectedGender = value;
    });
  },
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  ),
),

const SizedBox(height: 30),

// Continue Button (Conditional)
ElevatedButton(
  onPressed: _canContinue ? _submitProfileData : null,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFB800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 12,
    ),
  ),
  child:  Text(
    languageProvider.translate('Continue', context),
    style: const TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
  ),
),
                  


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
