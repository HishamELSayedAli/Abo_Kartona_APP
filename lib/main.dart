import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:realm/realm.dart';
import 'features/auth/models/user_model.dart';

late final Realm realm;

void main() {
  final config = Configuration.local([UserModel.schema]);
  realm = Realm(config);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'abo-Kartona',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.home,

      
      builder: (context, child) {
        
        return child!;
      },
    );
  }
}
