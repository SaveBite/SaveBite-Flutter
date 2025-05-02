import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repo/recipe_repository.dart';
import '../datasources/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Recipe>> getRecipe(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChat = await RecipeRemoteDataSource.fetchRecipe(query);
        if (remoteChat != null) {
          return Right(remoteChat);
        } else {
          return Left(ServerFailure(message: "Received null response from server, possibly due to invalid API response format"));
        }
      } catch (e) {
        return Left(ServerFailure(message: "Failed to fetch recipe: $e"));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }
}