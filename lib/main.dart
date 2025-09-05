import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:realm/realm.dart';
import 'features/auth/models/user_model.dart';

// Realm instance accessible globally
late final Realm realm;

void main() {
  // Initialize Realm before runApp
  final config = Configuration.local([UserModel.schema]);
  realm = Realm(config);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopzy',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.home,
    );
  }
}
