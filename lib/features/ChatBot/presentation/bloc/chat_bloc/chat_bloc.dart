import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/store_message_response.dart';
import '../../../domain/usecases/send_message.dart';
import '../../../domain/usecases/toggle_favorite.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessage sendMessage;
  final ToggleFavorite toggleFavorite;

  ChatBloc(this.sendMessage, this.toggleFavorite) : super(ChatInitial()) {
    on<SendChatMessageEvent>((event, emit) async {
      emit(ChatLoading());
      print("📦 ChatBloc: Sending message: ${event.message.message}");

      try {
        final Either<Failure, StoreMessageResponse> result =
        await sendMessage(event.message);
        result.fold(
              (failure) => emit(ChatError(message: failure.message)),
              (message) => emit(ChatMessageLoaded(message)),
        );
      } catch (e) {
        emit(ChatError(message: e.toString()));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      emit(ChatLoading());
      print("📦 ChatBloc: Toggling favorite for message ID: ${event.messageId}");

      try {
        final Either<Failure, StoreMessageResponse> result =
        await toggleFavorite(event.messageId, event.isFavourite);
        result.fold(
              (failure) => emit(ChatError(message: failure.message)),
              (message) => emit(ChatFavoriteToggled(event.messageId, message.favourite)),
        );
      } catch (e) {
        emit(ChatError(message: e.toString()));
      }
    });
  }
}