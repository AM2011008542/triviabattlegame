import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:triviabattlegame/pages/users.dart';
import '../animated/custom_form_button.dart';
import '../animated/custom_input_field.dart';
import '../animated/page_header.dart';
import '../animated/page_heading.dart';
import 'login.dart';
import 'main_home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File? _profileImage;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController pointController = TextEditingController();
  final TextEditingController ToQController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  final _signupFormKey = GlobalKey<FormState>();

  bool hasInternet = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Sign Up"),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: Form(
            key: _signupFormKey,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: Image.asset('assets/Create-a-kahoot.png'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: 130,
                        height: 130,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
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
                                      border: Border.all(
                                          color: Colors.white, width: 3),
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
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          labelText: 'Name',
                          hintText: 'Your name',
                          isDense: true,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return 'Name is required!';
                            }
                            nameController.text = name;
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          labelText: 'Email',
                          hintText: 'Your email id',
                          isDense: true,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Email is required!';
                            }
                            if (!EmailValidator.validate(email)) {
                              return 'Please enter a valid email';
                            }
                            emailController.text = email;
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                        labelText: 'Password',
                        hintText: 'Your password',
                        isDense: true,
                        obscureText: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Password is required!';
                          }
                          passwordController.text = password;
                          return null;
                        },
                        suffixIcon: true,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      CustomFormButton(
                          innerText: 'Sign up',
                          onPressed: () async {
                            hasInternet =
                                await InternetConnectionChecker().hasConnection;
                            if (hasInternet == true) {
                              checkProfilePic();
                            } else {
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.error(
                                  message: "No internet connection.",
                                ),
                              );
                            }
                          }),
                      const SizedBox(
                        height: 18,
                      ),
                      /*SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Already have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                                SystemChrome.setEnabledSystemUIMode(
                                    SystemUiMode.leanBack
                                )
                              },
                              child: const Text('Log-in', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUpUser() async {
    if (_signupFormKey.currentState!.validate()) {
      // show current text form field output
      print(emailController.text.trim());
      print(passwordController.text.trim());

      // sign up handling error method
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        // create database
        createDB(
            userName: nameController.text,
            userEmail: emailController.text,
            userPassword: passwordController.text,
            userPhone: phoneController.text,
            userCourse: courseController.text,
            userBio: bioController.text,
            userLocation: locationController.text,
            userPoint: 1000,
            userToQ: 0,
            userImage: imageController.text);

        // go to home interface
        Navigator.pop(
            context, MaterialPageRoute(builder: (context) => const MainHome()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showTopSnackBar(
            context,
            const CustomSnackBar.error(
              message: "The password provided is too weak.",
            ),
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showTopSnackBar(
            context,
            const CustomSnackBar.error(
              message: "The account already exists for that email.",
            ),
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _profileImage = imageTemporary);
    } on PlatformException catch (e) {
      const CustomSnackBar.error(
        message: "Failed to pick image error.",
      );
      debugPrint('Failed to pick image error: $e');
    }
  }

  void checkProfilePic() async {
    if (_profileImage == null) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Profile picture is empty!",
        ),
      );
    } else if (_profileImage != null) {
      _handleSignUpUser();
    }
  }

  Future<void> createDB(
      {required String userName,
      required String userEmail,
      required String userPassword,
      required String userPhone,
      required String userCourse,
      required String userBio,
      required String userLocation,
      required int userPoint,
      required int userToQ,
      required String userImage}) async {
    try {
      showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message: "Congratulations, you've received 1000 points!",
        ),
      );

      // get current user id
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser!;
      final uid = user.uid;

      // upload profile pic to database
      final file = File(_profileImage!.path);

      final refRoot = FirebaseStorage.instance.ref();
      Reference refDirImages = refRoot.child("users").child(uid);

      await refDirImages.putFile(file);
      String image = await refDirImages.getDownloadURL();

      print("Profile pic successfully uploaded!");

      List<String> splitList = userName.split(" ");
      List<String> indexList = [];
      final database = FirebaseFirestore.instance;

      for (int i = 0; i < splitList.length; i++) {
        for (int j = 0; j < splitList[i].length + i; j++) {
          indexList.add(splitList[i].substring(0, j).toLowerCase());
        }
      }
      /*database.collection("searchIndex").add({
        'userName': userName,
        'imageUrl': image,
        'searchIndex': indexList}
      );*/

      // reference to document
      final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

      final users = Users(
        userID: userDoc.id,
        //userPhoto: _profileImage,
        userEmail: emailController.text,
        userPassword: passwordController.text,
        userName: nameController.text,
        userPhone: phoneController.text,
        userCourse: courseController.text,
        userBio: bioController.text,
        userLocation: locationController.text,
        userPoint: 1000,
        userToQ: 0,
        imageUrl: image,
        index: indexList,
      );
      final json = users.toJson();
      await userDoc.set(json);

      print("Database successfully created!");
    } on PlatformException catch (e) {
      debugPrint('Failed to create database');
    }
  }
}
