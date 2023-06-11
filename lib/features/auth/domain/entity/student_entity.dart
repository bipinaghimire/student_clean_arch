import 'package:student_clean_arch/features/batch/domain/entity/batch_entity.dart';
import 'package:student_clean_arch/features/home/domain/entity/course_entity.dart';

class StudentEntity {
  final String? id;
  final String fname;
  final String lname;
  final BatchEntity? batch;
  final List<CourseEntity> courses;
  final String phone;
  final String username;
  final String password;

  StudentEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.batch,
    required this.courses,
    required this.phone,
    required this.username,
    required this.password,
  });
}
