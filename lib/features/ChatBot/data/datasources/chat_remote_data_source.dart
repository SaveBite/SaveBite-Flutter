import 'package:dio/dio.dart';
import '../../../../core/network/auth_local_data_source.dart';
import '../../domain/entities/store_message.dart';
import '../models/store_message_model.dart';
import '../models/store_message_response_model.dart';

abstract class ChatRemoteDataSource {
  Future<StoreMessageResponseModel> sendMessage({
    required StoreMessage storeMessage,
  });

  Future<StoreMessageResponseModel> toggleFavorite(
      int messageId, bool isFavourite);

  Future<Set<StoreMessageResponseModel>> getFavoriteMessages();

  Future<List<StoreMessageResponseModel>> getChatMessages();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;
  static const String baseUrl =
      "https://save-bite.ghoneim.makkah.tech/DashBoard/api/v1/mobile";

  ChatRemoteDataSourceImpl({required this.dio});

  @override
  Future<StoreMessageResponseModel> sendMessage({
    required StoreMessage storeMessage,
  }) async {
    final user = await AuthLocalDataSource.getUser();
    final token = user?.token;
    try {
      final response = await dio.post(
        '$baseUrl/chat/',
        data: StoreMessageModel(
          message: storeMessage.message,
          is_bot: storeMessage.is_bot,
        ).toJson(),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("📡 API RESPONSE: ${response.data}");

      final responseData = response.data as Map<String, dynamic>;
      if (responseData['status'] == 200) {
        return StoreMessageResponseModel.fromJson(responseData['data']);
      } else {
        throw Exception(
            'API returned non-200 status: ${responseData['status']}');
      }
    } catch (e) {
      if (e is DioException) {
        print("❌ DioError: ${e.message}");
        print("❌ Response: ${e.response?.data}");
        throw Exception('Dio error: ${e.message}');
      } else {
        print("❌ Unknown error: $e");
        throw Exception('Failed to send message: $e');
      }
    }
  }

  @override
  Future<StoreMessageResponseModel> toggleFavorite(
      int messageId, bool isFavourite) async {
    final user = await AuthLocalDataSource.getUser();
    final token = user?.token;
    try {
      final response = await dio.post(
        '$baseUrl/chat/add-to-favourites/$messageId',
        data: {'is_favourite': isFavourite},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("📡 TOGGLE FAVORITE RESPONSE: ${response.data}");
      final responseData = response.data as Map<String, dynamic>;
      if (responseData['status'] == 200) {
        return StoreMessageResponseModel.fromJson(responseData['data']);
      } else {
        throw Exception(
            'API returned non-200 status: ${responseData['status']}');
      }
    } catch (e) {
      if (e is DioException) {
        print("❌ DioError: ${e.message}");
        print("❌ Response: ${e.response?.data}");
        throw Exception('Dio error: ${e.message}');
      } else {
        print("❌ Unknown error: $e");
        throw Exception('Failed to toggle favorite: $e');
      }
    }
  }

  @override
  Future<Set<StoreMessageResponseModel>> getFavoriteMessages() async {
    final user = await AuthLocalDataSource.getUser();
    final token = user?.token;
    try {
      final response = await dio.get(
        '$baseUrl/chat/favorites',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("📡 GET FAVORITE MESSAGES RESPONSE: ${response.data}");
      final responseData = response.data as Map<String, dynamic>;
      if (responseData['status'] == 200) {
        final List<dynamic> messages = responseData['data'];
        return messages
            .map((json) => StoreMessageResponseModel.fromJson(json))
            .toSet();
      } else {
        throw Exception(
            'API returned non-200 status: ${responseData['status']}');
      }
    } catch (e) {
      if (e is DioException) {
        print("❌ DioError: ${e.message}");
        print("❌ Response: ${e.response?.data}");
        throw Exception('Dio error: ${e.message}');
      } else {
        print("❌ Unknown error: $e");
        throw Exception('Failed to fetch favorite messages: $e');
      }
    }
  }
  @override
  Future<List<StoreMessageResponseModel>> getChatMessages() async {
    final user = await AuthLocalDataSource.getUser();
    final token = user?.token;
    try {
      final response = await dio.get(
        '$baseUrl/chat/',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("📡 GET CHAT MESSAGES RESPONSE: ${response.data}");
      final responseData = response.data as Map<String, dynamic>;
      if (responseData['status'] == 200) {
        final List<dynamic> messages = responseData['data'];
        return messages
            .map((json) => StoreMessageResponseModel.fromJson(json))
            .toList();
      } else {
        throw Exception('API returned non-200 status: ${responseData['status']}');
      }
    } catch (e) {
      if (e is DioException) {
        print("❌ DioError: ${e.message}");
        print("❌ Response: ${e.response?.data}");
        throw Exception('Dio error: ${e.message}');
      } else {
        print("❌ Unknown error: $e");
        throw Exception('Failed to fetch chat messages: $e');
      }
    }
  }
}
