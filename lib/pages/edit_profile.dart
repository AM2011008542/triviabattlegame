import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:triviabattlegame/pages/profile.dart';
import 'package:triviabattlegame/pages/users.dart';
import 'package:triviabattlegame/trivia/ui/pages/home.dart';
import '../animated/custom_form_button.dart';
import '../animated/custom_input_field.dart';
import '../animated/page_heading.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {

  File? _profileImage;

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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final _editProfile = GlobalKey<FormState>();

  bool hasInternet = false;

  Future<void> loadRefresh() async {
    userList.clear();

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
  build(BuildContext context) {
    return MaterialApp(
      title: "Profile interface",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
          appBar: AppBar(
              elevation: 0,
              title: const Text("Edit Profile"),
              centerTitle: true,
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration:
                  const BoxDecoration(color: Colors.green),
                  height: 200,
                ),
              ),
              RefreshIndicator(
                child: userList.isEmpty ? const Center(child: SpinKitCircle(color: Colors.green)) : ListView.builder (
                    itemCount: userList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      return userUI(name, phone, course, bio, location, image);
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
  Widget userUI(String name, String phone, String course, String bio, String location, String image) {
    return Card (
      elevation: 10.0,
      child: Form(
        key: _editProfile,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: pickProfileImage,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  border: Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_sharp,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  CustomInputField(
                      labelText: 'Name :',
                      hintText: name,
                      isDense: true,
                      validator: (name) {
                        if(name == null || name.isEmpty) {
                          return 'Name is required!';
                        }
                        nameController.text = name;
                        return null;
                      }
                  ),

                  const SizedBox(height: 16,),
                  CustomInputField(
                      labelText: 'Bio :',
                      hintText: bio,
                      isDense: true,
                      validator: (bio) {
                        if(bio == null || bio.isEmpty) {
                          return 'Name field is required!';
                        }
                        bioController.text = bio;
                        return null;
                      }
                  ),

                  const SizedBox(height: 16,),
                  CustomInputField(
                      labelText: 'Course :',
                      hintText: course,
                      isDense: true,
                      validator: (course) {
                        if(course == null || course.isEmpty) {
                          return 'Name field is required!';
                        }
                        courseController.text = course;
                        return null;
                      }
                  ),

                  const SizedBox(height: 16,),
                  CustomInputField(
                      labelText: 'Contact Number :',
                      hintText: phone,
                      isDense: true,
                      validator: (phone) {
                        if(phone == null || phone.isEmpty) {
                          return 'Contact number is required!';
                        }
                        phoneController.text = phone;
                        return null;
                      }
                  ),

                  const SizedBox(height: 16,),
                  CustomInputField(
                      labelText: 'Location :',
                      hintText: location,
                      isDense: true,
                      validator: (location) {
                        if(location == null || location.isEmpty) {
                          return 'Name field is required!';
                        }
                        locationController.text = location;
                        return null;
                      }
                  ),

                  const SizedBox(height: 22,),
                  CustomFormButton(innerText: 'Submit',
                      onPressed: () async {
                        hasInternet = await InternetConnectionChecker().hasConnection;
                        if(hasInternet == true) {
                          checkProfilePic();
                        } else {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message:
                              "No internet connection.",
                            ),
                          );
                        }
                      }),
                  const SizedBox(height: 130,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // retrieve data from firestore
  getUserData() async {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge
    );

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

  Future<void> editProfile() async {
    if (_editProfile.currentState!.validate()) {
      final FirebaseAuth auth = FirebaseAuth.instance;

      final User user = auth.currentUser!;
      final uid = user.uid;

      final docUser = FirebaseFirestore.instance.collection("users").doc(uid);

      // upload profile pic to database
      final file = File(_profileImage!.path);

      final refRoot = FirebaseStorage.instance.ref();
      Reference refDirImages = refRoot.child("users").child(uid);

      refDirImages.delete();

      await refDirImages.putFile(file);
      String image = await refDirImages.getDownloadURL();

      List<String> splitList = nameController.text.split(" ");
      List<String> indexList = [];
      for(int i = 0; i < splitList.length; i++) {
        for(int j = 0 ; j < splitList[i].length + i; j++) {
          indexList.add(splitList[i].substring(0, j).toLowerCase());
        }
      }

      docUser.update({
        'userName': nameController.text,
        'userPhone': phoneController.text,
        'userCourse': courseController.text,
        'userBio': bioController.text,
        'userLocation': locationController.text,
        'imageUrl': image,
        'index': indexList,
      });

      print("User profile update successfully!");

      Navigator.pop(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
      print('Edit Profile');

      showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message:
          "User profile update successfully!",
        ),
      );

      SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.leanBack
      );
    }
  }

  void pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _profileImage = imageTemporary);

    } on PlatformException catch (e) {
      const CustomSnackBar.error(
        message:
        "Failed to pick image error.",
      );
      debugPrint('Failed to pick image error: $e');
    }
  }

  void checkProfilePic() async {
    if(_profileImage == null) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message:
          "Please pick your new profile picture!",
        ),
      );
    } else if(_profileImage != null) {
      editProfile();
    }
  }
}