//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newapp/backend.dart';
import 'package:newapp/pages/businessprofile.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart'; // Import your LanguageProvider
import '../widgets/language_dropdown.dart'; 
//import 'package:newapp/pages/businessprofile.dart';

class BusinessProfilePage extends StatefulWidget {
  const BusinessProfilePage({super.key});

  @override
  State<BusinessProfilePage> createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
  final _ownerController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();

  List<BusinessType> _businessTypes = [];
  List<String> _productTypes = [];
  String? _selectedBusinessType;
  String? _selectedProduct;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    Backend.fetchBusinessTypes().then((list) {
      setState(() => _businessTypes = list);
    });

    _ownerController.addListener(_validateForm);
    _businessNameController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _pincodeController.addListener(_validateForm);
  }

  Future<void> _submitForm() async {
    final profileData = {
      'ownerName': _ownerController.text.trim(),
      'businessName': _businessNameController.text.trim(),
      'businessType': _selectedBusinessType!,
      'productType': _selectedProduct!,
      'address': _addressController.text.trim(),
      'pincode': _pincodeController.text.trim(),
    };

    try {   
      final docId = await Backend.submitBusinessProfile(profileData);
      // ignore: unnecessary_null_comparison
      if (docId!= null) {
          Navigator.push(context,
        MaterialPageRoute(builder: (context) => BusinessProfileSetupPage(docId: docId)),);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission failed. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _ownerController.text.isNotEmpty &&
          _businessNameController.text.isNotEmpty &&
          _addressController.text.isNotEmpty &&
          _pincodeController.text.isNotEmpty &&
          _selectedBusinessType != null &&
          _selectedProduct != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          LanguageDropdown(), // Add the language dropdown here
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', height: height * .18),
                    const SizedBox(width: 16),
                     Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languageProvider.translate('GramaKart',context),
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                           Text(
                            languageProvider.translate("Your Craft, Our Platform - Grow with Confidence.",context),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildTextField(languageProvider.translate('Owner Name',context), _ownerController),
                _buildTextField(languageProvider.translate('Business Name', context), _businessNameController),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: DropdownButtonFormField<String>(
                    value: _selectedBusinessType,
                    hint:  Text(
                      languageProvider.translate('Business Type',context)
                      ),
                    items: _businessTypes.map((bt) {
                      return DropdownMenuItem(
                          value: bt.id, child: Text(languageProvider.translate(bt.name,context)));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedBusinessType = val;
                        _productTypes = [];
                        _selectedProduct = null;
                      });
                      _validateForm();
                      if (val != null) {
                        Backend.fetchProductTypes(val).then((plist) {
                          setState(() => _productTypes = plist);
                          _validateForm();
                        });
                      }
                    },
                    decoration: _inputDecoration(),
                  ),
                ),

                _buildTextField(languageProvider.translate('Address', context), _addressController),
                _buildTextField(languageProvider.translate('Pincode', context), _pincodeController),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: DropdownButtonFormField<String>(
                    value: _selectedProduct,
                    hint:  Text(
                      languageProvider.translate('Product/Service Type',context)),
                    items: _productTypes
                        .map((p) => DropdownMenuItem(value: p, child: Text(languageProvider.translate(p,context))))
                        .toList(),
                    onChanged: (v) {
                      setState(() => _selectedProduct = v);
                      _validateForm();
                    },
                    decoration: _inputDecoration(),
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB800),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _isFormValid ? _submitForm : null,
                    child:  Text(
                      languageProvider.translate('Continue',context),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16),
                 Text.rich(
                  TextSpan(
                    text: languageProvider.translate('By continuing, you agree to GramaKart’s',context),
                    style: const TextStyle(fontSize: 10),
                    children: [
                       TextSpan(
                        text: languageProvider.translate('Terms and Conditions',context),
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: TextFormField(
          controller: controller,
          decoration: _inputDecoration().copyWith(hintText: hint),
        ),
      );

  InputDecoration _inputDecoration() => InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1.5)),
      );
}
