import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/store_message_response.dart';
import '../repo/chat_repository.dart';

class GetChatMessages {
  final ChatRepository repository;

  GetChatMessages(this.repository);

  Future<Either<Failure, List<StoreMessageResponse>>> call() async {
    return await repository.getChatMessages();
  }
}