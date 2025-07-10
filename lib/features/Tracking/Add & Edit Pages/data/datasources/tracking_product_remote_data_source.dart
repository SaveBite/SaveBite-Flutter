// data/data_sources/tracking_remote_data_source.dart
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/auth_local_data_source.dart';
import '../models/tracking_product_model.dart';

abstract class TrackingRemoteDataSource {
  Future<Either<Exception, TrackingProductModel>> addTrackingProduct({
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
    File? image,
  });

  Future<Either<Exception, TrackingProductModel>> updateTrackingProduct({
    required int id,
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
    File? image,
  });

  Future<Either<Exception, String>> extractDateFromImage(File image);
}

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  // final AuthLocalDataSource authLocalDataSource;

  final http.Client client;

  TrackingRemoteDataSourceImpl( { required  this.client});

  @override
  Future<Either<Exception, TrackingProductModel>> addTrackingProduct({
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
     File? image,
  }) async {

    try {
      final user = await AuthLocalDataSource.getUser();
      final token = user?.token;

      if (token == null) {
        return Left(Exception('No authentication token available.'));
      }

      final uri = Uri.parse('https://save-bite.ghonim.makkah.solutions/api/v1/mobile/tracking-products');
      final request = http.MultipartRequest('POST', uri);

      request.fields['name'] = name;
      request.fields['numberId'] = numberId;
      request.fields['category'] = category;
      request.fields['label'] = label;
      request.fields['quantity'] = quantity.toString();
      if (startDate != null) request.fields['start_date'] = startDate;
      request.fields['end_date'] = endDate;
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image.path));
      }
      request.headers['Authorization'] = 'Bearer $token';

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return Right(TrackingProductModel.fromJson(data));
      } else {
        return Left(Exception('Failed to add product: ${response.body}'));
      }
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, TrackingProductModel>> updateTrackingProduct({
    required int id,
    required String name,
    required String numberId,
    required String category,
    required String label,
    required int quantity,
    String? startDate,
    required String endDate,
    File? image,
  }) async {
    try {
      final user = await AuthLocalDataSource.getUser();
      final token = user?.token;

      if (token == null) {
        return Left(Exception('No authentication token available.'));
      }

      final uri = Uri.parse('https://save-bite.ghonim.makkah.solutions/api/v1/mobile/tracking-products/$id');
      final request = http.MultipartRequest('POST', uri);

      request.fields['name'] = name;
      request.fields['numberId'] = numberId;
      request.fields['category'] = category;
      request.fields['label'] = label;
      request.fields['quantity'] = quantity.toString();
      if (startDate != null) request.fields['start_date'] = startDate;
      request.fields['end_date'] = endDate;
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image.path));
      }
      request.headers['Authorization'] = 'Bearer $token';

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return Right(TrackingProductModel.fromJson(data));
      } else {
        return Left(Exception('Failed to update product: ${response.body}'));
      }
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, String>> extractDateFromImage(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('https://savebite-edr.hossamohsen.me/api/capture'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"image_data": "data:image/jpeg;base64,$base64Image"}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final detections = data['detections'] as List;

        if (detections.isNotEmpty) {
          final dates = <String>[];

          for (final detection in detections) {
            final text = detection['text'] as List;
            if (text.isNotEmpty && text[0].isNotEmpty) {
              final dateText = text[0][0] as String;
              dates.add(dateText);
            }
          }

          if (dates.isNotEmpty) {
            return Right(dates.join(', ')); // Or return Right(dates) if you prefer a list
          }
        }

        return Left(Exception('No date found in image.'));
      } else {
        return Left(Exception('Failed to extract date: ${response.body}'));
      }
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}