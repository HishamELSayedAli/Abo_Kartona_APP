import 'package:realm/realm.dart';
import '../models/user_model.dart';
import 'package:uuid/uuid.dart' as uuid_pkg; // aliased to avoid conflict

class AuthRepository {
  final Realm realm;
  final uuid_pkg.Uuid _uuid = const uuid_pkg.Uuid(); // single instance

  AuthRepository(this.realm);

  UserModel? signIn(String email, String password) {
    final user = realm
        .all<UserModel>()
        .query("email == \$0 AND password == \$1", [email, password])
        .firstOrNull;
    return user;
  }

  UserModel signUp(String fullName, String email, String password) {
    final id = _uuid.v4(); // generate unique id
    final user = UserModel(
      id,
      fullName,
      email,
      password,
      false, // isLoggedIn set to false initially
    );
    realm.write(() {
      realm.add(user);
    });
    return user;
  }
  /// Get the currently logged-in user
   UserModel? getCurrentUser() {
    final results = realm.all<UserModel>().query("isLoggedIn == true");
    if (results.isEmpty) return null;
    return results.first;
  }

  /// Log out the current user
  void logout() {
    final current = getCurrentUser();
    if (current == null) return;

    realm.write(() {
      current.isLoggedIn = false;
    });
  }

}
