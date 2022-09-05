import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffEEF1F3),
      body: Center(
          child: Text('Search',
            style: TextStyle(fontSize: 60, color: Colors.blue),
          )
      ),
    );
  }
}