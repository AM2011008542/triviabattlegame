import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:triviabattlegame/pages/search_user_profile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {

  final TextEditingController searchController = TextEditingController();

  late String searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          searchString = val.toLowerCase();
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();

                              // reset method here

                            },
                          ),
                          hintText: "Search user here...",
                          hintStyle: const TextStyle(
                            fontFamily: "Antra",
                            color: Colors.blueGrey,
                          )
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: (searchString == null || searchString.trim() == "")
                          ? FirebaseFirestore.instance.collection("searchIndex").snapshots()
                          : FirebaseFirestore.instance.collection("searchIndex").where("searchIndex",
                          arrayContains: searchString).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError) {
                          return SizedBox(
                            child: Center(
                                child: EmptyWidget(
                                  packageImage: PackageImage.Image_4,
                                  hideBackgroundAnimation: true,
                                  title: "We got an error ${snapshot.error}]",
                                  titleTextStyle: const TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                  ),
                                )
                            ),
                          );
                        }
                        switch(snapshot.connectionState) {
                          case ConnectionState.waiting :
                            return SizedBox(
                              child: Center(
                                child: EmptyWidget(
                                  image: 'assets/no-found.gif',
                                  hideBackgroundAnimation: true,
                                  title: "Loading...",
                                  titleTextStyle: const TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                  ),
                                )
                              ),
                            );
                          case ConnectionState.none:
                            return SizedBox(
                              child: Center(
                                  child: EmptyWidget(
                                    packageImage: PackageImage.Image_4,
                                    hideBackgroundAnimation: true,
                                    title: "None...",
                                    titleTextStyle: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20,
                                    ),
                                  )
                              ),
                            );
                          case ConnectionState.done:
                            return SizedBox(
                              child: Center(
                                  child: EmptyWidget(
                                    packageImage: PackageImage.Image_4,
                                    hideBackgroundAnimation: true,
                                    title: "Done...",
                                    titleTextStyle: const TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20,
                                    ),
                                  )
                              ),
                            );
                          case ConnectionState.active:
                            return ListView(
                                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(Navigator.push(context, MaterialPageRoute(builder: (context) => SearchUserProfilePage())),
                                          transition: Transition.downToUp,
                                          arguments: document.id);
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(document["imageUrl"]),
                                      ),
                                      title: Text(document["userName"]),
                                      subtitle: Text(document["userName"]),
                                    ),
                                  );
                                }).toList()
                            );
                        }
                      },
                    ),
                  )
                ],
              ),
          )
        ],
      )
    );
  }
}