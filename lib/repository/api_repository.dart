import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/exercise.dart';

class ApiRepository {
   String url;
   ApiRepository({required this.url});

  Future<http.Response> fetchExercise() async {
    try {
      final response = await http.get(Uri.parse(url))/*.timeout(const Duration(seconds: 40))*/;

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 404) {
        throw Exception('Post not found');
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException {
      throw Exception('HTTP error');
    } on FormatException {
      throw Exception('Bad response format');
    } on TimeoutException {
      throw Exception('Request timeout');
    }
  }
}
