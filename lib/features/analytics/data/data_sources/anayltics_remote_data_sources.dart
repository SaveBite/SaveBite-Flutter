import 'package:dio/dio.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/analytics/data/model/anyltics_model.dart';
import 'package:save_bite/features/analytics/data/model/sales_data_model.dart';
import 'package:save_bite/features/analytics/domain/entity/sales_data_entity.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';

abstract class AnaylticsRemoteDataSources {
  Future<AnalyticsModel> fetchAnaylticsDetails();
  Future<SalesDataEntity> getSalesData();
}

class AnaylticsRemoteDataSourcesImp extends AnaylticsRemoteDataSources {
  final Dio dio;
  final String baseUrl = kBaseUrl;

  AnaylticsRemoteDataSourcesImp({required this.dio});
  @override
  Future<AnalyticsModel> fetchAnaylticsDetails() async {
    String token = SaveUserData.user!.token;
    final response = await dio.get(
      '$baseUrl/analytics',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    AnalyticsModel ananylticsModel =
        AnalyticsModel.fromJson(response.data["data"]);
    return ananylticsModel;
  }

  @override
  Future<SalesDataEntity> getSalesData() async {
    String token = SaveUserData.user!.token;
    final response = await dio.get(
      '$baseUrl/analytics/sales-predictions',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final salesDataModel = SalesDataModel.fromJson(response.data['data']);
    return (salesDataModel);
  }
}
