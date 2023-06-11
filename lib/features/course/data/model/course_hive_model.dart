import 'package:hive/hive.dart';
import 'package:student_clean_arch/config/constants/hive_table_constant.dart';
import 'package:uuid/uuid.dart';

// dart run build_runner build --delete-conflicting-outputs
part 'course_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel {
  @HiveField(0)
  final String courseId;
  @HiveField(1)
  final String courseName;

  //empty contructor
  CourseHiveModel.empty() : this(courseId: "", courseName: "");

  CourseHiveModel({
    String? courseId,
    required this.courseName,
  }) : courseId = courseId ?? const Uuid().v4();

  @override
  String toString() =>
      'CourseEntity(courseId: $courseId, courseName: $courseName)';
}
