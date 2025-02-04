import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_screen_customer.dart';
import 'package:flutter_application_1/welcome_screen.dart';

import 'firebase_options.dart'; // Firebase configuration
import 'firestore.dart'; // FirestoreService for database operations

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: 'Flea Market App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const WelcomeHomeScreen(), // Set HomePage as the starting screen
    );
  }
}

/// Home Page with Firestore Example
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeHomeScreen()));
            FirestoreService firestoreService = FirestoreService();
            final userId = "example_uid"; // Unique user ID
            final user = <String, dynamic>{
              "first": "Ada",
              "last": "Lovelace",
              "born": 1815,
            };

            try {
              // Pass both userId and user data to the addUser method
              await firestoreService.addUser(userId, user);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User added successfully!')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to add user: $e')),
              );
            }
          },
          child: const Text('Add User'),
        ),

      ),
    );
  }
}
