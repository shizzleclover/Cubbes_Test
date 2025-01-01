// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cubbes/model/country.dart';
 

class Countryapi {
  static String apiUrl = 'https://restcountries.com/v3.1/all';
  

  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
