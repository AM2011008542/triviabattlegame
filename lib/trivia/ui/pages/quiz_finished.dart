import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triviabattlegame/trivia//models/question.dart';
import 'package:triviabattlegame/trivia//ui/pages/check_answers.dart';
import 'package:triviabattlegame/pages/users.dart';

class QuizFinishedPage extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;

  QuizFinishedPage({Key? key, required this.questions, required this.answers}): super(key: key);

  @override
  State<QuizFinishedPage> createState() => _QuizFinishedPageState();
}

class _QuizFinishedPageState extends State<QuizFinishedPage> {
  int correctAnswers = 0;

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
  late List<String> index;

  List<Users>userList = [];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

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
      image = ds.data()!["imageUrl"];
      index = ds.data()!["index"];

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

  @override
  Widget build(BuildContext context){
    int correct = 0;
    widget.answers.forEach((index,value){
      if(widget.questions[index].correctAnswer == value) {
        correct++;
      }
    });
    const TextStyle titleStyle = TextStyle(
      color: Colors.black87,
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );
    final TextStyle trailingStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );

    return WillPopScope(
      onWillPop: () async {
        print("Back button pressed");
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Result'),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: const Text("Total Questions", style: titleStyle),
                    trailing: Text("${widget.questions.length}", style: trailingStyle),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: const Text("Score", style: titleStyle),
                    trailing: Text("${correct/widget.questions.length * 100}%", style: trailingStyle),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: const Text("Correct Answers", style: titleStyle),
                    trailing: Text("$correct/${widget.questions.length}", style: trailingStyle),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: const Text("Incorrect Answers", style: titleStyle),
                    trailing: Text("${widget.questions.length - correct}/${widget.questions.length}", style: trailingStyle),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                      child: const Text("Check Answers"),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CheckAnswersPage(questions: widget.questions, answers: widget.answers,)
                        ));
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                      child: const Text("Done"),
                      onPressed: () {
                        // update user point
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final User user = auth.currentUser!;
                        final uid = user.uid;
                        final docUser = FirebaseFirestore.instance.collection("users").doc(uid);
                        docUser.update({
                          'userPoint': point + correct,
                          'userToQ': ToQ + widget.questions.length,
                        });
                        print("User point update successfully!");

                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('Warning!'),
      content: const Text('Are you sure you want to quit the quiz? All your progress will be lost!'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CupertinoDialogAction(
            child: const Text("Okay"),
            onPressed: () {
              Navigator.of(context).pop(true);
              // hide system overlay
              SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.leanBack
              );
            }),
      ],
    ),
  );
}