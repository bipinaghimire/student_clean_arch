import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/core/failure/failure.dart';
import 'package:student_clean_arch/features/course/data/data_source/course_remote_data_source.dart';
import 'package:student_clean_arch/features/course/domain/entity/course_entity.dart';
import 'package:student_clean_arch/features/course/domain/repository/course_repository.dart';

final courseRemoteRepoProvider = Provider<ICourseRepository>(
  (ref) => CourseRemoteRepoImpl(
    courseRemoteDataSource: ref.read(courseRemoteDataSourceProvider),
  ),
);

class CourseRemoteRepoImpl implements ICourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRemoteRepoImpl({required this.courseRemoteDataSource});
  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    return courseRemoteDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    return courseRemoteDataSource.getAllCourses();
  }
}
