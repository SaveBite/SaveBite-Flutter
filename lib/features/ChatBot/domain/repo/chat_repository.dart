import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/store_message.dart';
import '../entities/store_message_response.dart';

abstract class ChatRepository {
  Future<Either<Failure, StoreMessageResponse>> sendMessage(StoreMessage message);
  Future<Either<Failure, StoreMessageResponse>> toggleFavorite(int messageId, bool isFavourite);
  Future<Either<Failure, Set<StoreMessageResponse>>> getFavoriteMessages();
  Future<Either<Failure, List<StoreMessageResponse>>> getChatMessages();
}