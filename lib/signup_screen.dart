import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_screen_customer.dart';

import 'firestore.dart'; // Import FirestoreService

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _userType = 'seller'; // Default user type
  String _errorMessage = '';
  bool _isLoading = false;

  // Function to handle signup
  Future<void> _signup() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_password != _confirmPassword) {
        setState(() {
          _errorMessage = "Passwords do not match";
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _errorMessage = ''; // Reset the error message
      });

      try {
        // Create user
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // Add user data to Firestore
        await _firestoreService.addUser(userCredential.user!.uid, {
          'name': _name,
          'email': _email,
          'userType': _userType,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup Successful!')),
        );

        // Navigate to the appropriate home screen
        if (_userType == 'seller') {
          Navigator.pushReplacementNamed(context, '/seller_home');
        } else if (_userType == 'customer') {
          Navigator.pushReplacementNamed(context, '/customer_home');
        } else if (_userType == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin_home');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message ?? "Signup failed. Please try again.";
        });
      } catch (e) {
        setState(() {
          _errorMessage = "An error occurred. Please try again.";
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0, // Removes the AppBar shadow
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.lightGreenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or Icon
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/logo.jpeg'),
                  ),
                  const SizedBox(height: 20),

                  // Name field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _name = value.trim();
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _email = value.trim();
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _password = value.trim();
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _confirmPassword = value.trim();
                    },
                  ),
                  const SizedBox(height: 30),

                  // User Type Dropdown
                  DropdownButton<String>(
                    value: _userType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _userType = newValue!;
                      });
                    },
                    items: <String>['seller', 'customer', 'admin']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Signup button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signup,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.teal)
                        : const Text(
                            'Signup',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Already have an account text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Error message display
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
