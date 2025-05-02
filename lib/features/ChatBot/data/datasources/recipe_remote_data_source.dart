import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';

class RecipeRemoteDataSource {
  static const String _baseUrl = 'https://savebite.hossamohsen.me/generate-recipe?=';

  static Future<RecipeModel?> fetchRecipe(String query) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      print("📡 API RESPONSE: ${response}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("📡 API RESPONSE: ${data}");
        return RecipeModel.fromJson(data);
      } else {
        print('Failed: ${response.statusCode}');
        throw Exception('Failed to fetch recipe');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
