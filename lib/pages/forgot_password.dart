import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../animated/custom_form_button.dart';
import '../animated/custom_input_field.dart';
import '../animated/page_header.dart';
import '../animated/page_heading.dart';
import 'login.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  final _forgetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Forgot Password"),
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
            key: _forgetPasswordFormKey,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.3,
                  child: Image.asset('assets/Create-a-kahoot.png'),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                const SizedBox(height: 20,),
                CustomFormButton(innerText: 'Submit', onPressed: _handleForgetPassword,),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleForgetPassword() {
    // forget password
    if (_forgetPasswordFormKey.currentState!.validate()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      choiceAction();
      verifyEmail();
    }
  }

  Future verifyEmail() async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
  }

  void choiceAction() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Email Sent Successfully!'),
        content: const Text('Kindly check your email as we have sent out reset password. For those who have not received, please check your spam inbox message.'),
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