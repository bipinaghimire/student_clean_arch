import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/config/constants/api_endpoint.dart';
import 'package:student_clean_arch/core/failure/failure.dart';
import 'package:student_clean_arch/core/network/remote/http_service.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(dio: ref.read(httpServiceProvider)),
);

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  // uploadusing multipart
  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "profilePicture": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      return Right(response.data["data"]);
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
