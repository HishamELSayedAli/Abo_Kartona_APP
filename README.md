<<<<<<< HEAD
# e_commerce_app

A new Flutter project.
=======
# Abo_Kartona_APP
A Flutter e-commerce app with Riverpod state management, Realm for local storage, and Navigator 2.0 routing.
# 🛒 Flutter E-Commerce App

A simple **E-Commerce application** built with **Flutter** & **Riverpod** for state management.

---

## 🚀 Features
- **User Authentication** (Login / Register)
- **Product Listing** (with search functionality)
- **Product Details** (view price, description, image)
- **Cart Management**
  - Add / remove products
  - Increase / decrease quantity
  - Checkout & clear cart
- **Order History**
  - View all past orders with details
- Clean **MVVM + Repository** architecture

---

## 🛠 Tech Stack
- **Flutter** (Dart)
- **Riverpod** (State management)
- **Material 3**
- **Navigator 2.0** (for routing)

---

## 📂 Project Structure


     core/
        config/
        errors/
        network/
        routing/
          app_router.dart
    
    features/
      
       auth/ 
            models/ 
                user_model.dart 
               user_model.realm.dart 
            providers/ 
                auth_provider.dart 
            repository/ 
                auth_repository.dart 
            views/ 
                signup.dart 
                login.dart
      cart/
          models/ 
             cart_model.dart 
          providers/ 
              cart_provider.dart 
          repository/ 
             .. 
          views/ 
          cart_screen.dart 
      
      orders/
        models/ 
             order_model.dart
          providers/ 
              order_provider.dart
          repository/ 
             .. 
          views/ 
            order_history_screen.dart
        
      
      
      
     products/ 
           models/ 
               product_model.dart 
          providers/ 
                product_providers.dart 
          repository/ 
              product_repository.dart 
          views/ 
              product_details_view.dart 
              product_screen.dart
      -home.dart
    shared/
    main.dart 


---
⚙️ Getting Started
    

Clone the repository:

    git clone [YOUR_REPOSITORY_URL]


Navigate to the project directory:

    cd [your_project_name]


Install dependencies:

    flutter pub get


Generate Realm models:

  Realm requires code generation for models.
    <!-- end list -->

    flutter pub run build_runner build --delete-conflicting-outputs


  Run the application:

    flutter run

---

> **Developed by [HishamELSayedAli](https://github.com/HishamELSayedAli)**
