import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/analytics/data/model/anyltics_model.dart';
import 'package:save_bite/features/analytics/domain/repos/anayltics_repo.dart';

class FetchAnylticsDetailsUseCase {
  final AnaylticsRepo anaylticsRepo;

  FetchAnylticsDetailsUseCase({required this.anaylticsRepo});

  Future<Either<Failure, AnalyticsModel>> call() {
    return anaylticsRepo.fetchAnaylticsDetails();
  }
}
