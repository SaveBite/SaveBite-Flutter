import 'package:dio/dio.dart';
import '../models/recipe_model.dart';
import 'dart:convert'; // Add this import for jsonDecode

class RecipeRemoteDataSource {
  static const String _baseUrl = 'https://savebite.hossamohsen.me/generate-recipe?=';

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  static Future<RecipeModel?> fetchRecipe(String query) async {
    try {
      final response = await _dio.post(
        '',
        data: {'query': query},
      );

      print("📡 API RESPONSE: ${response.data}");

      // Parse the 'result' field, which contains a JSON string
      final responseData = response.data as Map<String, dynamic>;
      final resultString = responseData['result'] as String;

      // Remove the ```json markers and decode the JSON string
      final cleanedJsonString = resultString
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();
      final recipeJson = jsonDecode(cleanedJsonString) as Map<String, dynamic>;

      return RecipeModel.fromJson(recipeJson);
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }
}