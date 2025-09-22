// lib/screens/nav_page.dart
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pickleballmobileapp/screens/book_screen.dart';
import 'package:pickleballmobileapp/screens/conversationn_screen.dart';
import 'package:pickleballmobileapp/screens/location_picker_screen.dart';
import 'package:pickleballmobileapp/screens/more_screen.dart';
import 'package:pickleballmobileapp/screens/notifications_screen.dart';
import 'package:pickleballmobileapp/screens/play_page.dart';
import 'package:pickleballmobileapp/screens/profile_screen.dart';
import 'package:pickleballmobileapp/styles/app_theme.dart';
import 'package:pickleballmobileapp/widgets/custom_appbar.dart';
import 'home_page.dart';

class NavPage extends StatefulWidget {
  final dynamic currentPage;

  const NavPage({super.key, this.currentPage = 0});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  late int _currentIndex = widget.currentPage;
  final moreTabIndex = 4;

  // Pages for each tab (index 0 = Home by default)
  // Replace Placeholder widgets with real screens when ready.
  final List<Widget> _pages = const [
    HomeScreen(), // default
    PlayPage(),
    //Scaffold(body: Center(child: Text('Event'))),
    BookScreen(),
    MoreScreen(),
  ];

  void _onBottomNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  // AppBar actions delegate into current page handlers via callbacks if needed.
  void _showLocationPicker() {
    // Implement location picker
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );
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
              _currentIndex == 0 ? Icons.home : Icons.home_outlined,
              size: _currentIndex == 0 ? 35 : 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              LineIcons.tableTennis,
              size: _currentIndex == 1 ? 35 : 25,
            ), //Image.asset('lib/assests/play_icon.png',width: 70,height: 25,),
            label: 'Play',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.attractions_sharp),
          //   label: 'Event',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_baseball_outlined,
              size: _currentIndex == 2 ? 35 : 25,
            ),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_customize,
              size: _currentIndex == 3 ? 35 : 25,
            ),
            label: 'More',
          ),
        ],
        onTap: _onBottomNavTap,
      ),
    );
  }
}
