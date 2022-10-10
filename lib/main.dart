// @dart=2.12

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:triviabattlegame/auth_service.dart';
import 'package:triviabattlegame/pages/login.dart';
import 'package:triviabattlegame/pages/main_home.dart';

Future<void> main()  async {
 WidgetsFlutterBinding.ensureInitialized();

 // hide system overlay
 SystemChrome.setEnabledSystemUIMode(
     SystemUiMode.leanBack
 );

 await Firebase.initializeApp();

 WidgetsFlutterBinding.ensureInitialized();

 runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null, //initial error
          ),
        ],
        child: MaterialApp(
          title: 'Trivia Battle Game',
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const AuthenticationWrapper(),
        )
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LoginPage();
          }
          return const MainHome();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }},
    );
  }
}