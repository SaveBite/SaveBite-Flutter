import 'package:equatable/equatable.dart';
import '../entities/recipe.dart';

class StoreMessageResponse extends Equatable {
  final int id;
  final String message;
  final bool me;
  final DateTime createdAt;
  final bool favourite;
  final bool isRecipe;
  final Recipe? recipe;

  StoreMessageResponse({
    required this.id,
    required this.message,
    required this.me,
    required this.createdAt,
    required this.favourite,
    this.isRecipe = false,
    this.recipe,
  });

  @override
  List<Object?> get props => [id, message, me, createdAt, favourite, isRecipe, recipe];
}