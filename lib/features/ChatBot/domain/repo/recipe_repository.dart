import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure,Recipe>> getRecipe(String query);
}
