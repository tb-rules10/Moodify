import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moodify/pages/AppScreens/ChatScreen.dart';
import 'package:moodify/pages/AppScreens/SearchScreen.dart';
import 'AppScreens/HomeScreen.dart';
import 'AppScreens/RadioScreen.dart';

class BottomNavbar extends StatefulWidget {
  static String id = "BottomNavbar";

  late String? searchQuery;
  BottomNavbar({
    this.searchQuery,
  });
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final PageController controller = PageController();
  int pageIndex = 0;
  late var screens;

  void setScreens(String? value){
    screens = [
      HomeScreen(),
      SearchScreen(searchQuery: value,),
      RadioHS(),
      ChatPage(),
    ];
  }

  @override
  void initState() {
    super.initState();
    setScreens(widget.searchQuery);
    if(widget.searchQuery != null) {
      pageIndex = 1;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.black,

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
              activeColor: Color(0xffB80454),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              // tabBackgroundColor: Colors.grey[800]!,
              tabBackgroundColor: Color(0xffB80454).withOpacity(0.15),
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
                  widget.searchQuery = null;
                  setScreens(null);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}