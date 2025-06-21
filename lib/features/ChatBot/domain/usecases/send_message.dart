import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/store_message.dart';
import '../entities/store_message_response.dart';
import '../repo/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<Either<Failure, StoreMessageResponse>> call(StoreMessage message) async {
    return await repository.sendMessage(message);
  }
}