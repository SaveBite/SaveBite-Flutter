import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:save_bite/features/ChatBot/domain/entities/recipe.dart';
import 'package:save_bite/features/ChatBot/presentation/bloc/recipe_event.dart';
import 'package:save_bite/features/ChatBot/presentation/bloc/recipe_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_recipe.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipe getRecipe;

  RecipeBloc(this.getRecipe) : super(RecipeInitial()) {
    // Handle GetRecipeEvent
    on<GetRecipeEvent>((event, emit) async {
      emit(RecipeLoading());
      print("📦 RecipeBloc: Fetching Recipe for query: ${event.query}");

      try {
        final Either<Failure, Recipe> result = await getRecipe(event.query);
        result.fold(
              (failure) => emit(RecipeError(message: failure.message)),
              (recipe) => emit(RecipeLoaded(recipe: recipe)),
        );
      } catch (e) {
        emit(RecipeError(message: e.toString()));
      }
    });

    // Handle an initial event to show the chatbot
    on<InitializeChatBotEvent>((event, emit) async {
      emit(RecipeLoaded(recipe: null)); // No recipe initially, just show chatbot
    });
  }
}