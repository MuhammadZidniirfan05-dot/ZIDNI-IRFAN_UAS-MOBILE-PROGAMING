import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'history_order_screen.dart';
import 'status_order_screen.dart';
import 'akun_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Masterprint Studio',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // Customize theme if needed
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: LoginScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Define the pages
  final List<Widget> _pages = [
    HomeScreen(),
    HistoryOrderScreen(), // Make sure this matches your actual class name
    StatusOrderScreen(), // Make sure this matches your actual class name
    AkunPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Add this if you have more than 3 items
        selectedItemColor:
            Colors.red, // Changed to match your app's color scheme
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Status Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
