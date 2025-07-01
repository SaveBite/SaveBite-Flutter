import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel(
      {required super.title,
      required super.prepTime,
      required super.ingredients,
      required super.instructions});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'] ?? '',
      prepTime: json['prep_time'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }
}
