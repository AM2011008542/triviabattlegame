import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triviabattlegame/trivia//models/category.dart';
import 'package:triviabattlegame/trivia//models/question.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:triviabattlegame/trivia//ui/pages/quiz_finished.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;

  const QuizPage({Key? key, required this.questions, required this.category})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }

    return WillPopScope(
      onWillPop: () async {
        print("Back Button Pressed");

        final shouldPop = await showWarning(context);

        return shouldPop ?? false;
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(widget.category.name),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text("${_currentIndex + 1}"),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          HtmlUnescape().convert(
                              widget.questions[_currentIndex].question),
                          softWrap: true,
                          style: MediaQuery.of(context).size.width > 800
                              ? _questionStyle.copyWith(fontSize: 30.0)
                              : _questionStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...options.map((option) => RadioListTile<String>( //<string>
                              title: Text(HtmlUnescape().convert("$option"),style: MediaQuery.of(context).size.width > 800
                              ? const TextStyle(
                                fontSize: 30.0
                              ) : null,),
                              groupValue: _answers[_currentIndex],
                              value: option,
                              onChanged: (value) {
                                setState(() {
                                  _answers[_currentIndex] = option;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton( // RaisedButton
                        /*padding: MediaQuery.of(context).size.width > 800
                              ? const EdgeInsets.symmetric(vertical: 20.0,horizontal: 64.0) : null,*/
                        onPressed: _nextSubmit,
                        child: Text(
                            _currentIndex == (widget.questions.length - 1)
                                ? "Submit"
                                : "Next", style: MediaQuery.of(context).size.width > 800
                              ? const TextStyle(fontSize: 30.0) : null,),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _nextSubmit() {
    if (_answers[_currentIndex] == null) {
      _key.currentState?.showSnackBar(const SnackBar( //snackbar fix
        content: Text("You must select an answer to continue."),
      ));
      return;
    }
    if (_currentIndex < (widget.questions.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => QuizFinishedPage(
              questions: widget.questions, answers: _answers)));
    }
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Warning!"),
      content: const Text("Are you sure you want to quit the quiz? All your progress will be lost."),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Okay"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}
