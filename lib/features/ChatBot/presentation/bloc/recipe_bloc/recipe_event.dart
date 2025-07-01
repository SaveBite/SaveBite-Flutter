import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class GetRecipeEvent extends RecipeEvent {
  final String query;

  const GetRecipeEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class InitializeChatBotEvent extends RecipeEvent {}