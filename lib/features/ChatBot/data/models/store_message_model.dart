import 'package:save_bite/features/ChatBot/domain/entities/store_message.dart';

class StoreMessageModel extends StoreMessage {
  StoreMessageModel({required super.message, required super.is_bot});

  factory StoreMessageModel.fromJson(Map<String, dynamic> json) {
    return StoreMessageModel(
      message: json['message'],
      is_bot: json['is_bot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'is_bot': is_bot,
    };
  }
}
