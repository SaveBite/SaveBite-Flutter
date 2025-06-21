import 'package:equatable/equatable.dart';

class StoreMessage extends Equatable {
  final String message;
  final bool is_bot;

  StoreMessage({
    required this.message,
    required this.is_bot,
  });

  @override
  List<Object?> get props => [message, is_bot];
}
