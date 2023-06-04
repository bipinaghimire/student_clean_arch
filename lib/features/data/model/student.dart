import 'package:hive/hive.dart';
import 'package:student_clean_arch/features/data/model/batch.dart';
import 'package:student_clean_arch/features/data/model/course.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 1)
class Student extends HiveObject {
  // HiveObject is a mixin that provides the ability to use Hive objects as keys
  // Which helps in serialization and deserialization
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? fname;

  @HiveField(2)
  final String? lname;

  @HiveField(3)
  final BatchEntity? batch;

  @HiveField(4)
  final List<CourseEntity> course;

  @HiveField(5)
  final String? phone;

  @HiveField(6)
  final String? username;

  @HiveField(7)
  final String? password;

  Student({
    String? id,
    this.fname,
    this.lname,
    this.batch,
    this.course = const [],
    this.phone,
    this.username,
    this.password,
  }) : id = id ?? const Uuid().v4();

  @override
  String toString() {
    return 'Student(id: $id, fname: $fname, lname: $lname, batch: $batch, course: $course, phone: $phone, username: $username, password: $password)';
  }
}
