import 'package:equatable/equatable.dart';
import '../../domain/entities/recipe.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final Recipe? recipe; // Allow null for initial chatbot display

  const RecipeLoaded({this.recipe});

  @override
  List<Object?> get props => [recipe];
}

class RecipeError extends RecipeState {
  final String message;

  const RecipeError({required this.message});

  @override
  List<Object?> get props => [message];
}