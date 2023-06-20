import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/core/failure/failure.dart';
import 'package:student_clean_arch/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:student_clean_arch/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepoProvider = Provider<IAuthRepository>(
  (ref) => AuthRemoteRepoImpl(
    authRemoteDataSource: ref.read(authRemoteDataSourceProvider),
  ),
);

class AuthRemoteRepoImpl implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, bool>> loginStudent(String username, String password) {
    // TODO: implement loginStudent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> registerStudent({
    required String fname,
    required String lname,
    String? image,
    required String batch,
    required List<String> courses,
    required String phone,
    required String username,
    required String password,
  }) {
    return authRemoteDataSource.registerStudent(
      fname: fname,
      lname: lname,
      image: image,
      batch: batch,
      courses: courses,
      phone: phone,
      username: username,
      password: password,
    );
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return authRemoteDataSource.uploadProfilePicture(file);
  }
}
