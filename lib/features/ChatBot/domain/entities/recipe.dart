import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String title;
  final String prepTime;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.title,
    required this.prepTime,
    required this.ingredients,
    required this.instructions,
  });

  @override
  List<Object?> get props =>
      [title, ingredients, instructions, prepTime];
}
