import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class PlaceDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  PlaceDetailsRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> getPlaceDetails(id) async {
    try {
      Response response = await dioClient.get(uri: "${EndPoints.place}/$id",
      queryParameters: {
        "client_id": sharedPreferences.getString(AppStorageKey.userId),

      }
      );
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
  Future<Either<ServerFailure, Response>> followPlace(id) async {
    try {
      Response response = await dioClient.post(uri: "${EndPoints.followPlace}",data:
      {
        "client_id": sharedPreferences.getString(AppStorageKey.userId),
        "place_id": id

      });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
  Future<Either<ServerFailure, Response>> checkFollowPlace(id) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.checkFollowPlace,data:
      {
        "client_id": sharedPreferences.getString(AppStorageKey.userId),
        "place_id": id

      });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
  Future<Either<ServerFailure, Response>> ratePlace(id,{ double? rate, String ?comment }) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.postFeedback,data:
      {
        "client_id": sharedPreferences.getString(AppStorageKey.userId),
        "place_id": id,
        "rating": rate,
        "comment": comment

      });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getPlaceOffers(id) async {
    try {
      Response response = await dioClient.get(uri: EndPoints.placeOffers(id));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }

  }
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }
  Future<Either<ServerFailure, Response>> getPlaceFeedBacks(id) async {
    try {
      Response response = await dioClient.get(uri: EndPoints.feedback(id));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}
