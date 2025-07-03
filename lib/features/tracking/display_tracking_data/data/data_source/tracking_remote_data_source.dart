import 'package:dio/dio.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';
import 'package:save_bite/features/tracking/display_tracking_data/data/model/tracking_product_model.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';

abstract class TrackingRemoteDataSource {
  Future<List<TrackingProductEntity>> getAllTrackingProducts();
  Future<void> deleteTrackingProduct(int id);
}

class TrackingRemoteDataSourceImp extends TrackingRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<List<TrackingProductEntity>> getAllTrackingProducts() async {
    final token = SaveUserData.user!.token;
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await dio.get(
      '$kBaseUrl/tracking-products',
      options: Options(headers: headers),
    );

    final data = response.data['data'] as List;
    return data.map((e) => TrackingProductModel.fromJson(e)).toList();
  }

  @override
  Future<void> deleteTrackingProduct(int id) async {
    final token = SaveUserData.user!.token;
    final headers = {
      'Authorization': 'Bearer $token',
    };

    await dio.delete(
      '$kBaseUrl/tracking-products/$id',
      options: Options(headers: headers),
    );
  }
}
