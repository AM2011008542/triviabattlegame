import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:triviabattlegame/trivia/ui/pages/home.dart';
import 'package:triviabattlegame/pages/leaderboard.dart';
import 'package:triviabattlegame/pages/profile.dart';
import 'package:triviabattlegame/pages/search.dart';

class MainHome extends StatefulWidget {
  const MainHome({ Key? key }) : super(key: key);

  @override
  _MainHome createState() => _MainHome();
}

class _MainHome extends State<MainHome> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int _currentIndex = 0;

  final pages = [
    HomePage(), //const
    const SearchPage(),
    const LeaderboardPage(),
    const ProfilePage(),
  ];

  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final item =  [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: const Text("Home"),
        selectedColor: Colors.red,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.search),
        title: const Text("Search"),
        selectedColor: Colors.purple,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.leaderboard),
        title: const Text("Leaderboard"),
        selectedColor: Colors.blue,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person),
        title: const Text("Profile"),
        selectedColor: Colors.green,
      ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.redAccent,
      body: pages[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
            items: item,
            onTap: (index) => setState(() {
              _currentIndex = index;
              if (index == 0) {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarColor: Colors.red,
                ));
                // hide system overlay
                SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.leanBack
                );
                print("Home interface");
              } else if (index == 1) {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarColor: Colors.purple,
                ));
                // hide system overlay
                SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.leanBack
                );
                print("Search interface");
              } else if(index == 2) {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarColor: Colors.blue,
                ));
                // hide system overlay
                SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.leanBack
                );
                print("Leaderboard interface");
              } else if(index == 3) {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarColor: Colors.green,
                ));
                // hide system overlay
                SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.leanBack
                );
                print("Profile interface");
              }
            })
        )
    );
  }
}
