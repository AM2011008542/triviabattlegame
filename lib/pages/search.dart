import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:triviabattlegame/pages/data_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {

  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  late bool isExecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(snapshotData.docs[index]['imageUrl']),
              ),
              title: Text(
                snapshotData.docs[index]["userName"],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                ),
              ),
              subtitle: Text(
                snapshotData.docs[index]["userCourse"],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                ),
              ),
            );
          }
      );
    }

    return MaterialApp(
      title: "Search interface",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          actions: [
            GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    onPressed: () {
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExecuted = true;
                        });
                      });
                    },
                    icon: const Icon(Icons.search)
                );
              },
            )
          ],
          elevation: 0,
          title: TextFormField(
            style: const TextStyle(
                color: Colors.white),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: Colors.white,
                      onPressed: () {
                      searchController.clear();
                        setState(() {
                          isExecuted = false;
                        });
                      },
                      icon: const Icon(Icons.clear)
                  ),
                  hintText: "Search user",
                  hintStyle: const TextStyle(
                      color: Colors.white
                  )
              ),
            controller: searchController,
            ),
        ),
        body: isExecuted ? searchedData() : Center(
          child: Image.asset(
              'assets/no-found.gif'
          ),
        ),
      ),
    );
  }
}