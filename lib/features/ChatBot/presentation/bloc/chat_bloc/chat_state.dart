import 'package:equatable/equatable.dart';

import '../../../domain/entities/store_message_response.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatMessageLoaded extends ChatState {
  final StoreMessageResponse message;
  const ChatMessageLoaded(this.message);
  @override
  List<Object?> get props => [message];
}

class ChatFavoriteToggled extends ChatState {
  final int messageId;
  final bool isFavourite;
  const ChatFavoriteToggled(this.messageId, this.isFavourite);
  @override
  List<Object?> get props => [messageId, isFavourite];
}

class ChatError extends ChatState {
  final String message;
  const ChatError({required this.message});
  @override
  List<Object?> get props => [message];
}
