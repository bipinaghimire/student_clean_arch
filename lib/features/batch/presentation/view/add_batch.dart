import 'package:flutter/material.dart';

class AddBatchScreen extends StatefulWidget {
  const AddBatchScreen({super.key});

  @override
  State<AddBatchScreen> createState() => _AddBatchScreenState();
}

class _AddBatchScreenState extends State<AddBatchScreen> {
  final _batchNameController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    _batchNameController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _batchNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Batch"),
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
                    controller: _batchNameController,
                    decoration: const InputDecoration(labelText: "Batch name"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Batch Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          // if (key.currentState!.validate()) {
                          //   setState(() {
                          //     BatchState.batches.add(BatchEntity(
                          //         batchName: _batchNameController.text));
                          //   });
                          //   Navigator.pop(context);
                          // }
                        },
                        child: const Text('Add Batch')),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
