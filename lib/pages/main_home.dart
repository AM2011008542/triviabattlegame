import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:triviabattlegame/pages/home.dart';
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

  String appbarTitleString = "Home";
  var appBarTitleText = const Text("Main");

  int _currentIndex = 0;

  final pages = [
    HomePage(), //const
    const SearchPage(),
    const LeaderboardPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget> [
      const Icon(Icons.home, size: 30),
      const Icon(Icons.search, size: 30),
      const Icon(Icons.leaderboard, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        elevation: 0,
        title: appBarTitleText,
        centerTitle: true,
      ),

      body: pages[_currentIndex],
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            child: CurvedNavigationBar(
              key: navigationKey,

              buttonBackgroundColor: Colors.purpleAccent,
              backgroundColor: Colors.transparent,
              height: 60,

              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 200),

              index: _currentIndex,
              items: items,
              onTap: (index) => setState(() {
                _currentIndex = index;
                if (index == 0) {
                  appbarTitleString = "Home" ;
                  appBarTitleText = Text(appbarTitleString);
                  print("Home interface");
                } else if (index == 1) {
                  appbarTitleString = "Search" ;
                  appBarTitleText = Text(appbarTitleString);
                  print("Search interface");
                } else if(index == 2) {
                  appbarTitleString = "Leaderboard" ;
                  appBarTitleText = Text(appbarTitleString);
                  print("Leaderboard interface");
                } else if(index == 3) {
                  appbarTitleString = "Profile" ;
                  appBarTitleText = Text(appbarTitleString);
                  print("Profile interface");
                }
              })
            )
        )
    );
  }
}
