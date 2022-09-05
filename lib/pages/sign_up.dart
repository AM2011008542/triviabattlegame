import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
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

  final _signupFormKey = GlobalKey<FormState>();

  Future _pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _profileImage = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image error: $e');
    }
  }

  bool hasInternet = false;

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.local(
        child: MaterialApp(
          title: 'Sign Up',
          home: SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xffEEF1F3),
              body: SingleChildScrollView(
                child: Form(
                  key: _signupFormKey,
                  child: Column(
                    children: [
                      const PageHeader(),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                        ),
                        child: Column(
                          children: [
                            const PageHeading(title: 'Sign-up',),
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
                                        onTap: _pickProfileImage,
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
                                labelText: 'Name',
                                hintText: 'Your name',
                                isDense: true,
                                validator: (name) {
                                  if(name == null || name.isEmpty) {
                                    return 'Name field is required!';
                                  }
                                  return null;
                                }
                            ),
                            const SizedBox(height: 16,),
                            CustomInputField(
                                labelText: 'Email',
                                hintText: 'Your email id',
                                isDense: true,
                                validator: (email) {
                                  if(email == null || email.isEmpty) {
                                    return 'Email is required!';
                                  }
                                  if(!EmailValidator.validate(email)) {
                                    return 'Please enter a valid email';
                                  }
                                  emailController.text = email;
                                  return null;
                                }
                            ),
                            const SizedBox(height: 16,),
                            CustomInputField(
                                labelText: 'Contact no.',
                                hintText: 'Your contact number',
                                isDense: true,
                                validator: (phone) {
                                  if(phone == null || phone.isEmpty) {
                                    return 'Contact number is required!';
                                  }
                                  return null;
                                }
                            ),
                            const SizedBox(height: 16,),
                            CustomInputField(
                              labelText: 'Password',
                              hintText: 'Your password',
                              isDense: true,
                              obscureText: true,
                              validator: (password) {
                                if(password == null || password.isEmpty) {
                                  return 'Password is required!';
                                }
                                passwordController.text = password;
                                return null;
                              },
                              suffixIcon: true,
                            ),
                            const SizedBox(height: 22,),
                            CustomFormButton(innerText: 'Signup',
                                onPressed: () async {
                                  hasInternet = await InternetConnectionChecker().hasConnection;
                                  if(hasInternet == true){
                                    _handleSignUpUser();
                                  } else {
                                    const color = Colors.redAccent;
                                    const text = 'No Internet';

                                    showSimpleNotification(
                                      const Text('$text',
                                        //style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      background: color,
                                    );
                                  }
                                  _handleSignUpUser();
                                }),
                            const SizedBox(height: 18,),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Already have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                                  GestureDetector(
                                    onTap: () => {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                                    },
                                    child: const Text('Log-in', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  Future<void> _handleSignUpUser() async {
    if (_signupFormKey.currentState!.validate()) {
      // show current text form field output
      print(emailController.text.trim());
      print(passwordController.text.trim());

      // sign up handling error method
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
        );

        Navigator.pop(context, MaterialPageRoute(builder: (context) => const MainHome()));

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSimpleNotification(
              const Text('The password provided is too weak.'),
              background: Colors.redAccent
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSimpleNotification(
              const Text('The account already exists for that email.'),
              background: Colors.redAccent
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}