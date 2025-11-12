import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/features/auth/views/login.dart';
import 'package:e_commerce_app/features/products/views/product_screen.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:e_commerce_app/features/auth/providers/auth_provider.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
  
}

class _HomeViewState extends ConsumerState<HomeView>  {
  int _currentIndex = 0;

  @override
   Widget build(BuildContext context) {
    final authProvider = ref.read(authProviderProvider.notifier); 

    final List<Widget> pages = [
      const Center(child: Text("Home Page Body")),
      const ProductsScreen(), // ✅ products screen
      const Center(child: Text("Orders History Page Body")),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Abo Kartona",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const Icon(Icons.person_outline),
        actions: [
          // زرار الـ Cart
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.cart);
              },
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),

          // زرار الـ Logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              authProvider.logout(); // 👈 هنا استدعينا الـ function بتاعتك
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginView()),
              );
            },
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Orders"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginView()),
          );
        },
        child: const Icon(Icons.login),
      ),
    );
  }
}
