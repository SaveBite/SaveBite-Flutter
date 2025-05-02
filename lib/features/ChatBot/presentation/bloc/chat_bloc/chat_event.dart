import 'package:equatable/equatable.dart';

import '../../../domain/entities/store_message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class SendChatMessageEvent extends ChatEvent {
  final StoreMessage message;
  const SendChatMessageEvent(this.message);
  @override
  List<Object?> get props => [message];
}

class ToggleFavoriteEvent extends ChatEvent {
  final int messageId;
  final bool isFavourite;
  const ToggleFavoriteEvent(this.messageId, this.isFavourite);
  @override
  List<Object?> get props => [messageId, isFavourite];
}