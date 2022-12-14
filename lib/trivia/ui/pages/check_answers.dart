import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:triviabattlegame/trivia//models/question.dart';

class CheckAnswersPage extends StatefulWidget {
  final List<Question> questions;
  final Map<int,dynamic> answers;
  final String difficulty;

  const CheckAnswersPage({Key? key, required this.questions, required this.answers, required this.difficulty})
      : super(key: key);

  @override
  State<CheckAnswersPage> createState() => _CheckAnswersPageState();
}

class _CheckAnswersPageState extends State<CheckAnswersPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.leanBack
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Check Answers'),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              height: 200,
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: widget.questions.length+1,
            itemBuilder: _buildItem,
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if(index == widget.questions.length) {
      return ElevatedButton(
        child: const Text("Exit"),
        onPressed: (){
          exitAction();
          SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.leanBack
          );
        },
      );
    }
    Question question = widget.questions[index];
    bool correct = question.correctAnswer == widget.answers[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(HtmlUnescape().convert(question.question), style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0
            ),),
            const SizedBox(height: 5.0),
            Text(HtmlUnescape().convert("${widget.answers[index]}"), style: TextStyle(
              color: correct ? Colors.green : Colors.red,
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 5.0),
            correct ? Container(): Text.rich(TextSpan(
              children: [
                const TextSpan(text: "Answer: "),
                TextSpan(text: HtmlUnescape().convert(question.correctAnswer) , style: const TextStyle(
                  fontWeight: FontWeight.w500
                ))
              ]
            ),style: const TextStyle(
              fontSize: 16.0
            ),)
          ],
        ),
      ),
    );
  }

  void exitAction() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) =>
          CupertinoAlertDialog(
            title: const Text('Warning!'),
            content: const Text('Are you sure you want to quit the quiz? All your progress will be lost!'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Cancel"),
                onPressed: () {
                  print("Cancel");
                  Navigator.of(context).pop(false);
                  SystemChrome.setEnabledSystemUIMode(
                      SystemUiMode.leanBack
                  );
                },
              ),
              CupertinoDialogAction(
                  child: const Text("Okay"),
                  onPressed: () {
                    print("Okay");
                    Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
                    SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.leanBack
                    );
                  }),
            ],
          ),
    );
  }
}