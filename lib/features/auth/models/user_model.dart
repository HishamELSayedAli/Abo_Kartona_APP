//! install realm package first
import 'package:realm/realm.dart';

part 'user_model.realm.dart';

@RealmModel()
class _UserModel {
  @PrimaryKey()
  late String id;

  late String name;
  late String email;
  late String password;

  /// to check if user is logged in or not
  late bool isLoggedIn;
}
