import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/config/constants/api_endpoint.dart';
import 'package:student_clean_arch/core/failure/failure.dart';
import 'package:student_clean_arch/core/network/remote/http_service.dart';
import 'package:student_clean_arch/core/shared_prefs/user_shared_pref.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, bool>> registerStudent({
    required String fname,
    required String lname,
    required String password,
    String? image,
    required String username,
    required String phone,
    required String batch,
    required List<String> courses,
  }) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          'fname': fname,
          'lname': lname,
          'password': password,
          'image': image ?? '',
          'username': username,
          'phone': phone,
          'batch': batch,
          'courses': courses,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

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

  Future<Either<Failure, bool>> loginStudent(
    String username,
    String password,
  ) async {
    try {
      Response response = await dio.post(ApiEndpoints.login, data: {
        'username': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
