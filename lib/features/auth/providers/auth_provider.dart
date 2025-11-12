import 'package:e_commerce_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../repository/auth_repository.dart';

/// الحالة (state) الخاصة بالمستخدم
class AuthState {
  final UserModel? currentUser;

  const AuthState({this.currentUser});

  bool get isLoggedIn => currentUser != null;

  AuthState copyWith({UserModel? currentUser}) {
    return AuthState(currentUser: currentUser ?? this.currentUser);
  }
}

/// الـ Notifier اللي بيحتوي على المنطق (بديل لـ ChangeNotifier)
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(AuthState()) {
    // عند تحميل التطبيق نحاول نجيب المستخدم الحالي
    final user = repository.getCurrentUser();
    if (user != null) {
      state = state.copyWith(currentUser: user);
    }
  }

  void signIn(String email, String password) {
    final user = repository.signIn(email, password);
    state = state.copyWith(currentUser: user);
  }

  void signUp(String name, String email, String password) {
    final user = repository.signUp(name, email, password);
    state = state.copyWith(currentUser: user);
  }

  void logout() {
    repository.logout();
    state = state.copyWith(currentUser: null);
  }
}

final authProviderProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = AuthRepository(realm);
  return AuthNotifier(repo);
});