import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:triviabattlegame/trivia//models/question.dart';
import 'package:triviabattlegame/trivia//ui/pages/check_answers.dart';

class QuizFinishedPage extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;

  QuizFinishedPage({Key? key, required this.questions, required this.answers}): super(key: key);

  @override
  State<QuizFinishedPage> createState() => _QuizFinishedPageState();
}

class _QuizFinishedPageState extends State<QuizFinishedPage> {
  int correctAnswers = 0;

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
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
                    child: const Text("Go to Home"),
                    onPressed: () {
                      // update user point
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final User user = auth.currentUser!;
                      final uid = user.uid;
                      final docUser = FirebaseFirestore.instance.collection("users").doc(uid);
                      docUser.update({
                        'userPoint': correct,
                      });
                      print("User point update successfully!");

                      Navigator.pop(context);
                      },
                  ),
                  ElevatedButton(
                    child: const Text("Check Answers"),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CheckAnswersPage(questions: widget.questions, answers: widget.answers,)
                      ));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}