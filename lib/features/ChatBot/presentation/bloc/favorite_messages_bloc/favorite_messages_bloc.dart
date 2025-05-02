import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_messages_event.dart';
part 'favorite_messages_state.dart';

class FavoriteMessagesBloc extends Bloc<FavoriteMessagesEvent, FavoriteMessagesState> {
  FavoriteMessagesBloc() : super(FavoriteMessagesInitial()) {
    on<FavoriteMessagesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
