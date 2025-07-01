import 'package:save_bite/features/ChatBot/domain/entities/store_message_response.dart';
import '../models/recipe_model.dart';

class StoreMessageResponseModel extends StoreMessageResponse {
  StoreMessageResponseModel({
    required super.id,
    required super.message,
    required super.me,
    required super.createdAt,
    required super.favourite,
    super.isRecipe = false,
    super.recipe,
  });

  factory StoreMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreMessageResponseModel(
      id: json['id'] as int,
      message: json['message'] as String,
      me: json['me'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      favourite: json['favourite'] as bool,
      isRecipe: json['is_recipe'] ?? false,
      recipe: json['recipe'] != null ? RecipeModel.fromJson(json['recipe']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'me': me,
      'created_at': createdAt.toIso8601String(),
      'favourite': favourite,
      'is_recipe': isRecipe,
      'recipe': recipe != null ? (recipe as RecipeModel) : null,
    };
  }
}