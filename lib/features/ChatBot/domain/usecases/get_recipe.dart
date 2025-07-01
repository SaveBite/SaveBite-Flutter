import 'package:dartz/dartz.dart';

import 'package:save_bite/core/error/failure.dart';

import '../entities/recipe.dart';
import '../repo/recipe_repository.dart';

class GetRecipe {
  final RecipeRepository repository;

  GetRecipe(this.repository);

  Future<Either<Failure, Recipe>> call(String query) async {
    return await repository.getRecipe(query);
  }
}
