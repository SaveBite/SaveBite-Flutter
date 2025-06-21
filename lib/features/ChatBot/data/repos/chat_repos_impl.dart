import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/store_message.dart';
import '../../domain/entities/store_message_response.dart';
import '../../domain/repo/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, StoreMessageResponse>> sendMessage(
      StoreMessage message) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.sendMessage(storeMessage: message);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(message: "Failed to send message: $e"));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, StoreMessageResponse>> toggleFavorite(
      int messageId, bool isFavourite) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.toggleFavorite(messageId, isFavourite);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(message: "Failed to toggle favorite: $e"));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, Set<StoreMessageResponse>>>
      getFavoriteMessages() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getFavoriteMessages();
        return Right(response);
      } catch (e) {
        return Left(
            ServerFailure(message: "Failed to fetch favorite messages: $e"));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }
  @override
  Future<Either<Failure, List<StoreMessageResponse>>> getChatMessages() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getChatMessages();
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(message: "Failed to fetch chat messages: $e"));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }
}