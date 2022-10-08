import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:triviabattlegame/pages/sign_up.dart';
import '../animated/custom_form_button.dart';
import '../animated/custom_input_field.dart';
import '../animated/page_header.dart';
import '../animated/page_heading.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  bool hasInternet = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'Log-in',),
                        CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email id',
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
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (password) {
                            if(password == null || password.isEmpty) {
                              return 'Password is required!';
                            }
                            passwordController.text = password;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          width: size.width * 0.80,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()))
                            },
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Color(0xff939393),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        CustomFormButton(innerText: 'Login',
                          onPressed: () async {
                            hasInternet = await InternetConnectionChecker().hasConnection;

                            if(hasInternet == true){
                              _handleLoginUser();
                            } else {
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.error(
                                  message:
                                  "No internet connection.",
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 18,),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()))
                                },
                                child: const Text('Sign-up', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLoginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      // show current text form field output
      print(emailController.text.trim());
      print(passwordController.text.trim());
      // sign in handling error method
      try {
        // sign in method
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
        );
        choiceAction();
        // hide system overlay
        SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.leanBack
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showTopSnackBar(
            context,
            const CustomSnackBar.error(
              message:
              "No user found for that email.",
            ),
          );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showTopSnackBar(
            context,
            const CustomSnackBar.error(
              message:
              "Wrong password provided for that user.",
            ),
          );
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  void choiceAction() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Welcome Back!'),
        content: const Text('We\'re happy that you\'re back! Hope you can beat other players!'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("Okay"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}