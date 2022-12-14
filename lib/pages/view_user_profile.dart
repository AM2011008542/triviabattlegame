import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:triviabattlegame/pages/users.dart';

class ViewUserProfilePage extends StatefulWidget {
  final String userID;

  const ViewUserProfilePage({Key? key, required this.userID}) : super(key: key);

  @override
  _ViewUserProfilePage createState() => _ViewUserProfilePage();
}

class _ViewUserProfilePage extends State<ViewUserProfilePage> {

  late String email;
  late String password;
  late String name;
  late String phone;
  late String course;
  late String bio;
  late String location;
  late int point;
  late int ToQ;
  late String image;
  late List<String> index = [];

  List<Users>userList = [];

  // retrieve data from firestore
  getUserData() async {
    await Future.delayed(const Duration(seconds: 1));

    await FirebaseFirestore.instance.collection('users').doc(widget.userID).get().then((ds) {
      email = ds.data()!["userEmail"];
      password = ds.data()!["userPassword"];
      name = ds.data()!["userName"];
      phone = ds.data()!["userPhone"];
      course = ds.data()!["userCourse"];
      bio = ds.data()!["userBio"];
      location = ds.data()!["userLocation"];
      point = ds.data()!["userPoint"];
      ToQ = ds.data()!["userToQ"];
      image = ds.data()!["imageUrl"];

      Users users = Users(userName: name, userEmail: email, userPassword: password,
          userPhone: phone, userCourse: course, userBio: bio, userLocation: location,
          userPoint: point, userToQ: ToQ, imageUrl: image, index: index);

      userList.add(users);

      print(userList.length);

      setState(() {
        print("Load user data");
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> loadRefresh() async {
    userList.clear();

    await Future.delayed(const Duration(seconds: 1));

    await FirebaseFirestore.instance.collection('users').doc(widget.userID).get().then((ds) {
      email = ds.data()!["userEmail"];
      password = ds.data()!["userPassword"];
      name = ds.data()!["userName"];
      phone = ds.data()!["userPhone"];
      course = ds.data()!["userCourse"];
      bio = ds.data()!["userBio"];
      location = ds.data()!["userLocation"];
      point = ds.data()!["userPoint"];
      ToQ = ds.data()!["userToQ"];
      image = ds.data()!["imageUrl"];

      Users users = Users(userName: name, userEmail: email, userPassword: password,
          userPhone: phone, userCourse: course, userBio: bio, userLocation: location,
          userPoint: point, userToQ: ToQ, imageUrl: image, index: index);

      userList.add(users);

      print(userList.length);

      setState(() {
        print("Refresh user data");
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  build(BuildContext context) {
    return GetMaterialApp(
      title: "Profile interface",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Profile"),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_outlined),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration:
                  const BoxDecoration(color: Colors.blue),
                  height: 200,
                ),
              ),
              RefreshIndicator(
                child: userList.isEmpty ? const Center(child: SpinKitCircle(color: Colors.blue)) : ListView.builder (
                    itemCount: userList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      return userUI(email, name, phone, course, bio, location, point, ToQ, image);
                    }
                ),
                onRefresh: () async {
                  await loadRefresh();
                },
              ),
            ],
          )
      ),
    );
  }

  // User profile design
  Widget userUI(String email, String name, String phone, String course, String bio, String location,
      int point, int ToQ, String image) {
    return Card (
      elevation: 10.0,
      child: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: double.infinity,
                child: Column(
                    children: [
                      const SizedBox(height: 10.0,),
                      CircleAvatar(
                        radius: 65.0,
                        backgroundImage: NetworkImage(image),
                        backgroundColor: Colors.black,
                      ),
                      const SizedBox(height: 10.0,),
                      Text(name,
                          style: const TextStyle(
                            color:Colors.black,
                            fontSize: 20.0,
                          )),
                      const SizedBox(height: 10.0,),
                      Text(email,
                        style: const TextStyle(
                          color:Colors.black,
                          fontSize: 15.0,
                        ),
                      )
                    ]
                )
            ),

            const SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Total of Questions',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0
                        ),),
                      const SizedBox(height: 10.0,),
                      Text("$ToQ",
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),)
                    ],
                  ),
                  Column(
                      children: [
                        const Text('Points',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                          ),),
                        const SizedBox(height: 10.0,),
                        Text('$point',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        )
                      ]
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20.0,),
            const Text("Bio :"),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: bio,
                  icon: const Icon(
                    Icons.person,
                    color: Colors.green,
                  )
              ),
            ),

            const SizedBox(height: 20.0,),
            const Text("Contact Number :"),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: phone,
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.green,
                  )
              ),
            ),

            const SizedBox(height: 20.0,),
            const Text("Course :"),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: course,
                  icon: const Icon(
                    Icons.book,
                    color: Colors.green,
                  )
              ),
            ),

            const SizedBox(height: 20.0,),
            const Text("Location :"),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: location,
                  icon: const Icon(
                    Icons.map,
                    color: Colors.green,
                  )
              ),
            ),

            const SizedBox(height: 80.0,),
          ],
        ),
      ),
    );
  }
}