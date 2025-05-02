import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/store_message_response.dart';
import '../repo/chat_repository.dart';

class ToggleFavorite {
  final ChatRepository repository;

  ToggleFavorite(this.repository);

  Future<Either<Failure, StoreMessageResponse>> call(int messageId, bool isFavourite) async {
    return await repository.toggleFavorite(messageId, isFavourite);
  }
}