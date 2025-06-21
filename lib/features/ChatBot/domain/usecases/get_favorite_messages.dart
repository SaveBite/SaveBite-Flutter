import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/store_message_response.dart';
import '../repo/chat_repository.dart';

class GetFavoriteMessages {
  final ChatRepository repository;

  GetFavoriteMessages(this.repository);

  Future<Either<Failure, Set<StoreMessageResponse>>> call() async {
    return await repository.getFavoriteMessages();
  }
}