import 'package:flutter/material.dart';
import 'package:student_clean_arch/features/data/model/batch.dart';
import 'package:student_clean_arch/features/data/model/course.dart';
import 'package:student_clean_arch/features/ui/widgets/multiselect.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phonenoController = TextEditingController();

  String? batch;
  String? course;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fkey = GlobalKey<FormState>();

  List<BatchEntity> batchList = [
    BatchEntity(batchId: "1", batchName: '30A'),
    BatchEntity(batchId: "2", batchName: '30B'),
  ];
  List<CourseEntity> selectedCourses = [];
  List<CourseEntity> availableCourses = [
    CourseEntity(courseId: "1", courseName: 'React'),
    CourseEntity(courseId: "2", courseName: 'Flutter'),
    CourseEntity(courseId: "3", courseName: 'Node'),
    CourseEntity(courseId: "4", courseName: 'Python'),
  ];

  void showMultiSelect() {
    MultiSelectDialog.showMultiSelect(
      context,
      availableCourses,
      selectedCourses,
      (List<CourseEntity> updatedCourses) {
        setState(() {
          selectedCourses = updatedCourses;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              DropdownButtonFormField<String?>(
                validator: (value) {
                  if (value == null) {
                    return 'Please select a batch';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Batch',
                  border: OutlineInputBorder(),
                ),
                value: batch,
                items: batchList.map((BatchEntity batch) {
                  return DropdownMenuItem<String?>(
                    value: batch.batchName,
                    child: Text(batch.batchName),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    batch = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: showMultiSelect,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Course',
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Selected Courses: ${selectedCourses.map((course) => course.courseName)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Student added"),
                    ),
                  );
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
