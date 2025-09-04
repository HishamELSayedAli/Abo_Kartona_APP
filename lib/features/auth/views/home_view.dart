import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import '../models/user_model.dart';

class UsersHomeView extends StatefulWidget {
  const UsersHomeView({super.key});

  @override
  State<UsersHomeView> createState() => _UsersHomeViewState();
}

class _UsersHomeViewState extends State<UsersHomeView> {
  late Realm realm;

  @override
  void initState() {
    super.initState();

    // Initialize Realm
    final config = Configuration.local([UserModel.schema]);
    realm = Realm(config);

    //! Adding a default user for testing if not exists
  final existing = realm.all<UserModel>().query(r"id == $0", ["1"]);
    // identifier "$" is hardcoded for simplicity -> r (row string)
    if (existing.isEmpty) {
      realm.write(() {
        realm.add(UserModel("1", "ambo", "bar3y@test.com", "123456", false));
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    //get the logged in user
    final loggedInUser =
        realm.all<UserModel>().query("isLoggedIn == true").firstOrNull;

    final users = realm.all<UserModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loggedInUser != null
              ? "Welcome back, ${loggedInUser.name}"
              : "Users Home",
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: user.isLoggedIn
                ? const Icon(Icons.check_circle, color: Colors.green)
                : IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      // Log in this user and log out others
                      realm.write(() {
                        for (var u in realm.all<UserModel>()) {
                          u.isLoggedIn = false;
                        }
                        user.isLoggedIn = true;
                      });
                      setState(() {}); // update UI
                    },
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }
}
