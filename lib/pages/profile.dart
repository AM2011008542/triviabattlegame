import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:triviabattlegame/pages/users.dart';
import '../animated/constants.dart';
import '../auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  late String email;
  late String password;
  late String name;
  late String phone;
  late String course;
  late String bio;
  late String location;
  late int point;
  late int ToQ;

  List<Users>userList = [];

  // retrieve data from firestore
  getUserData() async {
    await Future.delayed(const Duration(seconds: 1));
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User user = auth.currentUser!;
    final uid = user.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((ds) {
      email = ds.data()!["userEmail"];
      password = ds.data()!["userPassword"];
      name = ds.data()!["userName"];
      phone = ds.data()!["userPhone"];
      course = ds.data()!["userCourse"];
      bio = ds.data()!["userBio"];
      location = ds.data()!["userLocation"];
      point = ds.data()!["userPoint"];
      ToQ = ds.data()!["userToQ"];

      Users users = Users(userName: name, userEmail: email, userPassword: password,
          userPhone: phone, userCourse: course, userBio: bio, userLocation: location,
          userPoint: point, userToQ: ToQ);

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
    await Future.delayed(const Duration(seconds: 1));
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User user = auth.currentUser!;
    final uid = user.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((ds) {
      email = ds.data()!["userEmail"];
      password = ds.data()!["userPassword"];
      name = ds.data()!["userName"];
      phone = ds.data()!["userPhone"];
      course = ds.data()!["userCourse"];
      bio = ds.data()!["userBio"];
      location = ds.data()!["userLocation"];
      point = ds.data()!["userPoint"];
      ToQ = ds.data()!["userToQ"];

      Users users = Users(userName: name, userEmail: email, userPassword: password,
          userPhone: phone, userCourse: course, userBio: bio, userLocation: location,
          userPoint: point, userToQ: ToQ);

      userList.add(users);

      print(userList.length);

      setState(() {
        print("Refresh user data");
      });
    }).catchError((e) {
      print(e);
    });
  }

  // Get data from database
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: userList.isEmpty ? const Center(child: SpinKitCircle(color: Colors.green)) : ListView.builder (
            itemCount: userList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return userUI(email, name);
            }
        ),
        onRefresh: () async {
          await loadRefresh();
        },
      ),
    );
  }

  // User profile design
  Widget userUI(String email, String name) {
    return Card (
      elevation: 10.0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Email :"),
            TextFormField (
              enabled: false,
              decoration: InputDecoration(
                  hintText: email,
                  icon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  )
              ),
            ),

            const SizedBox(height: 20.0,),
            const Text("Name :"),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: name,
                  icon: const Icon(
                    Icons.email,
                    color: Colors.green,
                  )
              ),
            ),

          ],
        ),
      ),
    );
  }

  void logOutAction() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) =>
          CupertinoAlertDialog(
            title: const Text('Logging Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              CupertinoDialogAction(
                  child: const Text("Yes"),
                  onPressed: () {
                    print("User Log Out");
                    Navigator.of(context).pop(true);
                    context.read<AuthenticationService>().signOut();
                  }),
            ],
          ),
    );
  }

  void popupAction(String choice){
    if(choice == Constants.editProfile){
      print('Edit Profile');
    }
    else if(choice == Constants.logOut){
      print('Logout');
      logOutAction();
    }
  }
}