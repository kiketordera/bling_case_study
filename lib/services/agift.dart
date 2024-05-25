import 'dart:convert';

import 'package:bling_case_study/models/age_estimate.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.agify.io/';

  Future<AgeEstimate> getAgeEstimate(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl?name=$name'));
    if (response.statusCode == 200) {
      return AgeEstimate.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load age estimate');
    }
  }
}
