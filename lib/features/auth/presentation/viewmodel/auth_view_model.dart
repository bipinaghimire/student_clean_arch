import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/features/auth/domain/use_case/auth_usecase.dart';
import 'package:student_clean_arch/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState(isLoading: false));

  Future<void> registerStudent({
    required String fname,
    required String lname,
    String? image,
    required String batch,
    required List<String> courses,
    required String phone,
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerStudent(
      fname: fname,
      lname: lname,
      image: image,
      batch: batch,
      courses: courses,
      phone: phone,
      username: username,
      password: password,
    );
    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<bool> loginStudent(String username, String password) async {
    state = state.copyWith(isLoading: true);
    bool isLogin = false;
    var data = await _authUseCase.loginStudent(username, password);
    data.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        isLogin = success;
      },
    );

    return isLogin;
  }

  Future<void> uploadProfilePicture(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }
}
