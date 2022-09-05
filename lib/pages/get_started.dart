import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:triviabattlegame/auth_service.dart';
import 'package:triviabattlegame/pages/login.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({ Key? key }) : super(key: key);

  @override
  GetStartedState createState() => GetStartedState();
}

class GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6DEC8),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 50,),
            FadeInUp(
                duration: Duration(milliseconds: 1500),
                child: Image.network('https://cdn.dribbble.com/users/3484830/screenshots/16787618/media/b134e73ef667b926c76d8ce3f962dba2.gif', fit: BoxFit.cover,)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    delay: Duration(milliseconds: 1000),
                    duration: Duration(milliseconds: 1000),
                    child: Text("Learning code is now more easy", style: GoogleFonts.robotoSlab(
                        fontSize: 36,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  SizedBox(height: 10,),
                  FadeInUp(
                    delay: Duration(milliseconds: 1200),
                    duration: Duration(milliseconds: 1000),
                    child: Text("Are you ready to learn languages \neasily in the funniest way?", style: GoogleFonts.robotoSlab(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.grey.shade700
                    ),),
                  ),
                ],
              ),
            ),
            FadeInUp(
              delay: Duration(milliseconds: 1300),
              duration: Duration(milliseconds: 1000),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        color: Colors.black,
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: EdgeInsets.only(left: 25, right: 25, bottom: 4),
                        child: Center(
                          child: Text("Get Started", style: GoogleFonts.robotoSlab(
                              fontSize: 16,
                              color: Colors.white
                          ),),
                        )
                    ),
                    TextButton(
                        onPressed: () {
                          choiceAction();
                        },
                        child: Text("SKIP", style: GoogleFonts.robotoSlab(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.8,
                            color: Colors.black
                        ),)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
  void choiceAction() {
      showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Logging Out'),
          content: const Text('Are you sure you want to Log Out?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("No"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
                child: const Text("Yes"),
                onPressed: () {
                  print("Log Out");
                  Navigator.of(context).pop(true);
                  //sign out user account
                  context.read<AuthenticationService>().signOut();
                  //go to login interface
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                }
            ),
          ],
        ),// ignore: unnecessary_statements
      );
    }
}
