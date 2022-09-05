import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffEEF1F3),
      body: Center(
          child: Text('Home',
            style: TextStyle(fontSize: 60, color: Colors.blue),
          )
      ),
    );
  }
}