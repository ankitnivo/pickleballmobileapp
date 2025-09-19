// lib/screens/nav_page.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/screens/book_screen.dart';
import 'package:pickleballmobileapp/screens/conversationn_screen.dart';
import 'package:pickleballmobileapp/screens/more_screen.dart';
import 'package:pickleballmobileapp/screens/notifications_screen.dart';
import 'package:pickleballmobileapp/screens/play_page.dart';
import 'package:pickleballmobileapp/screens/profile_screen.dart';
import 'package:pickleballmobileapp/styles/app_theme.dart';
import 'package:pickleballmobileapp/widgets/custom_appbar.dart';
import 'home_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;
  final moreTabIndex = 4;

  // Pages for each tab (index 0 = Home by default)
  // Replace Placeholder widgets with real screens when ready.
  final List<Widget> _pages = const [
    HomeScreen(), // default
    PlayPage(),
    Scaffold(body: Center(child: Text('Event'))),
    BookScreen(),
    MoreScreen(),
  ];

  void _onBottomNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  // AppBar actions delegate into current page handlers via callbacks if needed.
  void _showLocationPicker() {
    // Implement location picker
  }

  void _handleMessage() {
    // Implement search
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConversationsScreen()),
    );
  }

  void _showNotifications() {
    // Show notifications
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsScreen()),
    );
  }

  void _showProfile() {
    // Show profile
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: _currentIndex == moreTabIndex
          ? null
          : CustomAppBar(
              location: 'Houston, Texas',
              onLocationTap: _showLocationPicker,
              onMessageTap: _handleMessage,
              onNotificationTap: _showNotifications,
              onProfileTap: _showProfile,
            ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.cream,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0 ? Icons.home_filled : Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_tennis),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attractions_sharp),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_baseball_outlined),
            label: 'Book',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
        onTap: _onBottomNavTap,
      ),
    );
  }
}
