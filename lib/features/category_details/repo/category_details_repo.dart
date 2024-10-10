import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class CategoryDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  CategoryDetailsRepo(
      {required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> getCategoryDetails(id,{String? minRate, Position? position,bool? offer,bool? latestOffer}) async {
    try {
      print({
        if (minRate != null && minRate != "null" && minRate != "0")
          "min_rate": minRate,
        if (position != null) "clientlat": position.latitude,
        if (position != null) "clientlong": position.longitude,
        if (offer != null&&offer) "offers": offer?"1":"0",
        if (latestOffer != null&&latestOffer) "latest_offers": latestOffer?"1":"0",
      });

      Response response = await dioClient.get(uri: "${EndPoints.category}/$id",data: {
      if (minRate != null && minRate != "null" && minRate != "0")
      "min_rate": minRate,
      if (position != null) "clientLat": position.latitude,
      if (position != null) "clientlong": position.longitude,
      if (offer != null&&offer) "offers": offer?"1":"0",
      if (latestOffer != null&&latestOffer) "latest_offers": latestOffer?"1":"0",
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

  Future<Either<ServerFailure, Response>> getSubCategoryDetails(id,
      {String? minRate, Position? position,bool? offer,bool? latestOffer}) async {
    try {
      print({
        if (minRate != null && minRate != "null" && minRate != "0")
          "min_rate": minRate,
        if (position != null) "clientlat": position.latitude,
        if (position != null) "clientlong": position.longitude,
        if (offer != null&&offer) "offers": offer?"1":"0",
        if (latestOffer != null&&latestOffer) "latest_offers": latestOffer?"1":"0",
      });
      Response response =
          await dioClient.get(uri: "${EndPoints.subCategory}/$id", data: {
        if (minRate != null && minRate != "null" && minRate != "0")
          "min_rate": minRate,
        if (position != null) "clientLat": position.latitude,
        if (position != null) "clientlong": position.longitude,
        if (offer != null&&offer) "offers": offer?"1":"0",
        if (latestOffer != null&&latestOffer) "latest_offers": latestOffer?"1":"0",
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
}
