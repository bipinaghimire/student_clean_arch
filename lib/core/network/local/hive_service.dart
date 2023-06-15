import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_clean_arch/config/constants/hive_table_constant.dart';
import 'package:student_clean_arch/features/batch/data/model/batch_hive_model.dart';

import '../../../features/auth/data/model/student_hive_model.dart';
import '../../../features/course/data/model/course_hive_model.dart';

final hiveServiceProvider = Provider(
  (ref) => HiveService(),
);

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    //register adapters
    Hive.registerAdapter(StudentHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
    Hive.registerAdapter(CourseHiveModelAdapter());

    //add dummy data
    await addDummybatch();
    await addDummycourse();
  }

  Future<void> addBatch(BatchHiveModel batch) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(batch.batchId, batch);
  }

  Future<List<BatchHiveModel>> getAllBatches() async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    var bacthes = box.values.toList();
    return bacthes;
  }

  //====================course queries==========================
  Future<void> addCourse(CourseHiveModel course) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.put(course.courseId, course);
  }

  Future<List<CourseHiveModel>> getAllCourses() async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    var courses = box.values.toList();
    return courses;
  }

  // ======================== Student Queries ========================
  Future<void> addStudent(StudentHiveModel student) async {
    var box =
        await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    await box.put(student.id, student);
  }

  Future<List<StudentHiveModel>> getAllStudents() async {
    var box =
        await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    var students = box.values.toList();
    box.close();
    return students;
  }

  //Login
  Future<StudentHiveModel?> login(String username, String password) async {
    var box =
        await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    var student = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return student;
  }

  //============================ Insert dummy data============================
  //bacth dummy data
  Future<void> addDummybatch() async {
    //check of batch box is empty
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    if (box.isEmpty) {
      final batch1 = BatchHiveModel(batchName: '29-A');
      final batch2 = BatchHiveModel(batchName: '29-B');
      final batch3 = BatchHiveModel(batchName: '30-A');
      final batch4 = BatchHiveModel(batchName: '30-B');

      List<BatchHiveModel> batches = [batch1, batch2, batch3, batch4];

      //insert batch key
      for (var batch in batches) {
        await box.put(batch.batchId, batch);
      }
    }
  }

  //course dummy data
  Future<void> addDummycourse() async {
    //check of course box is empty
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    if (box.isEmpty) {
      final course1 = CourseHiveModel(courseName: 'Flutter');
      final course2 = CourseHiveModel(courseName: 'Dart');
      final course3 = CourseHiveModel(courseName: 'Java');
      final course4 = CourseHiveModel(courseName: 'Kotlin');

      List<CourseHiveModel> courses = [course1, course2, course3, course4];

      //insert course key
      for (var course in courses) {
        await box.put(course.courseId, course);
      }
    }
  }
}
