import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repository/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository repository;
  UserModel? _currentUser;

  AuthProvider(this.repository) {
    /// When downloading the application, we try to bring the current user
    _currentUser = repository.getCurrentUser();
  }

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  void signIn(String email, String password) {
    _currentUser = repository.signIn(email, password);
    notifyListeners(); // updating for widgets
  
  }

  void signUp(String name, String email, String password) {
    _currentUser = repository.signUp(name, email, password);
    notifyListeners();
  }

  void logout() {
    repository.logout();
    _currentUser = null;
    notifyListeners();
  }
}
