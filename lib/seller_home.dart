import 'package:flutter/material.dart';

import 'SellerScreen/seller_edit.dart'; // Edit Page
import 'SellerScreen/seller_messages.dart'; // Messages Page
import 'SellerScreen/seller_profile.dart'; // Profile Page

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({Key? key}) : super(key: key);

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  int _selectedIndex = 0; // Current selected tab index
  final List<Widget> _pages = [
    // Pages for bottom navigation bar
    const Center(
      child: Text(
        'Welcome to Seller Home!',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    const SellerProfilePage(),
    const SellerMessagesPage(),
    const SellerEditPage(),
  ];

  /// Handles bottom navigation item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // Search bar
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Search button
              ElevatedButton(
                onPressed: () {
                  print("Search button pressed!");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          foregroundColor: Colors.black,
        ),
        body: _pages[_selectedIndex], // Display the current page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, // Currently selected tab
          onTap: _onItemTapped, // Handle tab selection
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
          ],
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true, // Display unselected tab labels
        ),
      ),
    );
  }
}
