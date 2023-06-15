import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:student_clean_arch/features/auth/domain/entity/student_entity.dart';
import 'package:student_clean_arch/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:student_clean_arch/features/batch/domain/entity/batch_entity.dart';
import 'package:student_clean_arch/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:student_clean_arch/features/course/domain/entity/course_entity.dart';
import 'package:student_clean_arch/features/course/presentation/viewmodel/course_view_model.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phonenoController = TextEditingController();

  String? batch;
  String? course;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fkey = GlobalKey<FormState>();

  // List<BatchEntity> batchList = [
  //   BatchEntity(batchId: "1", batchName: '30A'),
  //   BatchEntity(batchId: "2", batchName: '30B'),
  // ];
  // List<CourseEntity> selectedCourses = [];
  // List<CourseEntity> availableCourses = [
  //   CourseEntity(courseId: "1", courseName: 'React'),
  //   CourseEntity(courseId: "2", courseName: 'Flutter'),
  //   CourseEntity(courseId: "3", courseName: 'Node'),
  //   CourseEntity(courseId: "4", courseName: 'Python'),
  // ];

  // void showMultiSelect() {
  //   MultiSelectDialog.showMultiSelect(
  //     context,
  //     availableCourses,
  //     selectedCourses,
  //     (List<CourseEntity> updatedCourses) {
  //       setState(() {
  //         selectedCourses = updatedCourses;
  //       });
  //     } as Function(List p1),
  //   );
  // }

  BatchEntity? _dropDownValue;
  final List<CourseEntity> _selectedCourses = [];

  @override
  Widget build(BuildContext context) {
    final batchState = ref.watch(batchViewModelProvider);
    final courseState = ref.watch(courseViewModelProvider);
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Screen"),
      ),
      body: Form(
        key: fkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Register Screen",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phonenoController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              if (batchState.isLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                )
              } else if (batchState.error != null) ...{
                Center(
                  child: Text(batchState.error!),
                )
              } else ...{
                DropdownButtonFormField(
                  items: batchState.batches
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.batchName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _dropDownValue = value;
                  },
                  value: _dropDownValue,
                  decoration: const InputDecoration(
                    labelText: 'Select Batch',
                  ),
                  validator: ((value) {
                    if (value == null) {
                      return 'Please select batch';
                    }
                    return null;
                  }),
                )
              },
              if (courseState.isLoading) ...{
                const Center(
                  child: CircularProgressIndicator(),
                )
              } else if (courseState.error != null) ...{
                Center(
                  child: Text(courseState.error!),
                )
              } else ...{
                MultiSelectDialogField(
                  title: const Text('Select course'),
                  items: courseState.courses
                      .map((course) => MultiSelectItem(
                            course,
                            course.courseName,
                          ))
                      .toList(),
                  listType: MultiSelectListType.CHIP,
                  buttonText: const Text('Select course'),
                  buttonIcon: const Icon(Icons.search),
                  onConfirm: (values) {
                    _selectedCourses.clear();
                    _selectedCourses.addAll(values);
                  },
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select courses';
                    }
                    return null;
                  }),
                ),
              },
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (fkey.currentState!.validate()) {
                    var student = StudentEntity(
                      fname: firstNameController.text,
                      lname: lastNameController.text,
                      phone: phonenoController.text,
                      username: usernameController.text,
                      password: passwordController.text,
                      batch: _dropDownValue,
                      courses: _selectedCourses,
                    );

                    ref
                        .read(authViewModelProvider.notifier)
                        .registerStudent(student);

                    if (authState.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(authState.error!),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Successfully registered"),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
