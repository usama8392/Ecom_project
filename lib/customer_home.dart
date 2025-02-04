import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/welcome_screen.dart';

import 'cart_page.dart'; // Importing CartPage
import 'categories_page.dart'; // Importing CategoriesPage
import 'messages_page.dart'; // Importing MessagesPage
import 'profile_page.dart'; // Importing ProfilePage

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _selectedIndex = 0; // Current selected tab index
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Initialize the pages for the bottom navigation bar
    _pages = [
      // Home Page
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Search bar
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search items...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Search button
                ElevatedButton(
                  onPressed: () {
                    print("Search functionality triggered!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
        ],
      ),
      // Cart Page
      const CartPage(),
      // Profile Page
      const ProfilePage(),
      // Messages Page
      const MessagesPage(),
      // Categories Page
      const CategoriesPage(),
    ];
  }

  // Handle bottom navigation item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Logout functionality
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeHomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Flea Market',
          style: TextStyle(color: Colors.teal),
        ),
        centerTitle: true,
        elevation: 2.0,
        iconTheme: const IconThemeData(color: Colors.teal),
        actions: [
          // Logout icon in the top-right corner
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: _logout,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Currently selected tab
        onTap: _onItemTapped, // Handle tab selection
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true, // Show labels for unselected items
      ),
    );
  }
}
