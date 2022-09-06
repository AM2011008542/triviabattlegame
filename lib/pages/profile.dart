import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6DEC8),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          choiceAction();
                        },
                        color: Colors.black,
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 4),
                        child: Center(
                          child: Text("LOG OUT", style: GoogleFonts.robotoSlab(
                              fontSize: 16,
                              color: Colors.white
                          ),),)
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
                // exit system overlay
                SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.edgeToEdge
                );
              }),
        ],
      ),
    );
  }
}