import 'package:dartz/dartz.dart';
import 'package:wasla/core/enums/event_type.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/features/resident_service/features/home/data/models/service_provieders_search_model.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_event_model.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_model.dart';

abstract class HomeRepo {
  Future<Either<String, UserModel>> getResidentProfile({
    required String userId,
  });
  Future<Either<Failure, List<ServiceProviedersSearchModel>>>
  getAllServiceProviders({required int pageNumber, required int pageSize});
  Future<Either<String, List<ServiceProviedersSearchModel>>>
  searchAllServiceProviders({
    required int pageNumber,
    required int pageSize,
    required String query,
  });
  Future<Either<Failure, List<UserEventModel>>>
  getServiceProviderRecommendedForYou({
    required int top,
    required String residentId,
  });
  Future<Either<Failure, List<UserEventModel>>> getServiceProviderTopOfTheWeek({
    required int top,
  });
  Future<Either<String, Null>> createUserEvent({
    required String userId,
    required String serviceProviderId,
    required EventType eventType,
  });
}
