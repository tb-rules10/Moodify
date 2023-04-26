import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moodify/pages/AppScreens/SearchScreen.dart';
import 'AppScreens/HomeScreen.dart';

class BottomNavbar extends StatefulWidget {
  static String id = "BottomNavbar";

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int pageIndex = 0;
  final screens = [
    HomeScreen(),
    SearchScreen(),
    HomeScreen(),
    SearchScreen(),
  ];
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.black,
          color: Color(0xFF3D3F43),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[800]!,
              color: Colors.white,
              tabs: const [
                GButton(
                  icon:Icons.home_outlined,
                  text:'Home',
                ),
                GButton(
                  icon:Icons.search,
                  text:'Search',
                ),
                GButton(
                  icon:Icons.radio_outlined,
                  text:'Radio',
                ),
                GButton(
                  icon:Icons.chat_outlined,
                  text:'Assistant',
                ),
              ],
              selectedIndex: pageIndex,
              onTabChange: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}