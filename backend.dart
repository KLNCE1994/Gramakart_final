// lib/services/backend.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

const _baseUrl = 'http://192.168.0.3:3000';

class BusinessType {
  final String id, name;
  BusinessType(this.id, this.name);
  factory BusinessType.fromJson(Map<String, dynamic> j) =>
      BusinessType(j['id'], j['name']);
}

class Backend {
  static Future<List<BusinessType>> fetchBusinessTypes() async {
    print("Function Called");
    final resp = await http.get(Uri.parse('$_baseUrl/businessTypes'));
    if (resp.statusCode != 200) throw Exception('error');
    final List data = jsonDecode(resp.body);
    return data.map((e) => BusinessType.fromJson(e)).toList();
  }

  static Future<List<String>> fetchProductTypes(String businessTypeId) async {
    print("Func called");
    final resp = await http.get(Uri.parse(
        '$_baseUrl/productTypes?businessTypeId=${Uri.encodeComponent(businessTypeId)}'));
    if (resp.statusCode != 200) throw Exception('error');
    final List data = jsonDecode(resp.body);
    return List<String>.from(data);
  }

  static Future<String> submitBusinessProfile(Map<String, dynamic> data) async {
    print("here we are~~");
    final response = await http.post(
      Uri.parse('$_baseUrl/submitBusinessProfile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    print("Response body: ${response.body}");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("came inside");
      final responseData = jsonDecode(response.body);
      return responseData['id'];
    } else {
      return 'null';
    }
  }

  static Future<Map<String, dynamic>> sendBusinessProfile2({
    required String docId,
    required String role,
    required String gender,
    File? pic,
    Uint8List? webPic,
  }) async {
    const url = '$_baseUrl/submitBusinessProfile2';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'docId': docId,
        'role': role,
        'gender': gender,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      return {'success': false, 'error': 'Server Error'};
    }
  }

static Future<Map<String, dynamic>> fetchBusinessProfile(String docId) async {
    final uri = Uri.parse('$_baseUrl/sellerProfile?docId=${Uri.encodeComponent(docId)}');
    final resp = await http.get(uri);
    print("Here in the backend :) $docId and $resp");
    if (resp.statusCode != 200) {
      throw Exception('Failed to load profile (${resp.statusCode})');
    }
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

}
