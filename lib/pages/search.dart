import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Search interface",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Search"),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                const BoxDecoration(color: Colors.purple),
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}