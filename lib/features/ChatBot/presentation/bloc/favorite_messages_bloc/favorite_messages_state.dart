part of 'favorite_messages_bloc.dart';

abstract class FavoriteMessagesState extends Equatable {
  const FavoriteMessagesState();
  @override
  List<Object?> get props => [];
}

class FavoriteMessagesInitial extends FavoriteMessagesState {}

class FavoriteMessagesLoading extends FavoriteMessagesState {}

class FavoriteMessagesLoaded extends FavoriteMessagesState {
  final Set<StoreMessageResponse> messages;
  const FavoriteMessagesLoaded(this.messages);
  @override
  List<Object?> get props => [messages];
}

class FavoriteMessagesError extends FavoriteMessagesState {
  final String message;
  const FavoriteMessagesError(this.message);
  @override
  List<Object?> get props => [message];
}