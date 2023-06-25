import 'package:flutter/material.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _courseNameController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  // final List<CourseEntity> _lstCourses = CourseState.courses;

  @override
  void initState() {
    _courseNameController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Course"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
            child: Column(
              children: [
                TextFormField(
                  controller: _courseNameController,
                  decoration: const InputDecoration(labelText: "Course name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Course Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          // setState(() {
                          //   CourseState.courses.add(CourseEntity(
                          //       courseName: _courseNameController.text));
                          // });
                          // Navigator.pop(context);
                        }
                      },
                      child: const Text('Add Course')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
