import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/core/failure/failure.dart';
import 'package:student_clean_arch/features/course/data/repository/course_remote_repository_impl.dart';
import 'package:student_clean_arch/features/course/domain/entity/course_entity.dart';

final courseRepositoryProvider = Provider<ICourseRepository>(
  //return local repo implementaiton
  //for internet connectivity will check later
  (ref) => ref.read(courseRemoteRepoProvider),
);

abstract class ICourseRepository {
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
  Future<Either<Failure, bool>> addCourse(CourseEntity course);
}
