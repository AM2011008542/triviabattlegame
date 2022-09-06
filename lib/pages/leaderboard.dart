import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPage();
}

class _LeaderboardPage extends State<LeaderboardPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Leaderboard interface",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Leaderboard"),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                const BoxDecoration(color: Colors.blue),
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}