import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/store_message_response.dart';
import '../../../domain/usecases/get_favorite_messages.dart';

part 'favorite_messages_event.dart';
part 'favorite_messages_state.dart';

class FavoriteMessagesBloc extends Bloc<FavoriteMessagesEvent, FavoriteMessagesState> {
  final GetFavoriteMessages getFavoriteMessages;

  FavoriteMessagesBloc(this.getFavoriteMessages) : super(FavoriteMessagesInitial()) {
    on<FetchFavoriteMessages>((event, emit) async {
      emit(FavoriteMessagesLoading());
      print("📦 FavoriteMessagesBloc: Fetching favorite messages");

      try {
        final Either<Failure, Set<StoreMessageResponse>> result =
        await getFavoriteMessages();
        result.fold(
              (failure) => emit(FavoriteMessagesError(failure.message)),
              (messages) {
            // Filter out duplicates based on id
            final uniqueMessages = messages.toSet();
            emit(FavoriteMessagesLoaded(uniqueMessages));
          },
        );
      } catch (e) {
        emit(FavoriteMessagesError(e.toString()));
      }
    });
  }
}