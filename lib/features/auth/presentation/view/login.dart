import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/features/auth/presentation/viewmodel/auth_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final fkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Form(
        key: fkey,
        child: Center(
          child: Column(
            children: [
              const Text(
                "Login Screen",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (fkey.currentState!.validate()) {
                    await ref.read(authViewModelProvider.notifier).loginStudent(
                          context,
                          usernameController.text,
                          passwordController.text,
                        );
                    // We don't use Navigator and Snackbar here, but for
                    // time being, we will use it.
                    // if (isLogin) {
                    //   print(isLogin);
                    //   Navigator.pushNamed(context, '/home');
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text(
                    //         'Login failed',
                    //         style: TextStyle(
                    //           fontSize: 18,
                    //           fontFamily: 'Brand Bold',
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }
                  }
                },
                child: const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Brand Bold',
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
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
