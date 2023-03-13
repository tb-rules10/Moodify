import 'package:demo_music/pages/HomePage.dart';
import 'package:demo_music/pages/RadioPage.dart';
import 'package:demo_music/pages/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int pageIndex = 0;
  final screens = [
    HomePage(),
    SearchPage(),
    RadioHS(),
    SearchPage(),
  ];
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
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
