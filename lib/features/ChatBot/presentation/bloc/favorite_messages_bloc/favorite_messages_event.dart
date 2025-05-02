part of 'favorite_messages_bloc.dart';

abstract class FavoriteMessagesEvent extends Equatable {
  const FavoriteMessagesEvent();
  @override
  List<Object?> get props => [];
}

class FetchFavoriteMessages extends FavoriteMessagesEvent {}