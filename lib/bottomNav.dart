import 'package:demo_music/pages/homepage.dart';
import 'package:demo_music/pages/searchResults.dart';
import 'package:demo_music/pages/searchpage.dart';
import 'package:flutter/material.dart';

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
    ResultsPage(),
    SearchPage(),
  ];
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[pageIndex],
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment(0.0, 1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BottomNavigationBar(
                  selectedIconTheme: IconThemeData(color: Colors.white, size: 30, opacity: .8),
                  unselectedIconTheme: IconThemeData(color: Colors.grey, size: 25, opacity: .8),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.black,
                  currentIndex: pageIndex,
                  iconSize: 28,
                  onTap: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home",),
                    BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search",),
                    BottomNavigationBarItem(icon: Icon(Icons.music_note_outlined),label: "Music",),
                    BottomNavigationBarItem(icon: Icon(Icons.chat_outlined),label: "Assistant",),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
