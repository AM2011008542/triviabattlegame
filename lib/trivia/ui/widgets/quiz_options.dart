import 'dart:io';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:triviabattlegame/trivia//models/category.dart';
import 'package:triviabattlegame/trivia//models/question.dart';
import 'package:triviabattlegame/trivia//resources/api_provider.dart';
import 'package:triviabattlegame/trivia//ui/pages/error.dart';
import 'package:triviabattlegame/trivia//ui/pages/quiz_page.dart';

class QuizOptionsDialog extends StatefulWidget {
  final Category category;

  const QuizOptionsDialog({Key? key, required this.category}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  late int _noOfQuestions;
  late String _difficulty;
  late bool processing;

  bool musicPlaying = false;

  @override
  void initState() { 
    super.initState();
    _noOfQuestions = 10;
    _difficulty = "easy";
    processing = false;
    FlameAudio.bgm.initialize();
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey.shade200,
              child: Text(widget.category.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(),
              textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 10.0),
            const Text("Select Total Number of Questions"),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: <Widget>[
                  const SizedBox(width: 0.0),
                  ActionChip(
                    label: const Text("10"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 10 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(10),
                  ),
                  ActionChip(
                    label: const Text("20"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 20 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(20),
                  ),
                  ActionChip(
                    label: const Text("30"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 30 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(30),
                  ),
                  ActionChip(
                    label: const Text("40"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 40 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(40),
                  ),
                  ActionChip(
                    label: const Text("50"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _noOfQuestions == 50 ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectNumberOfQuestions(50),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text("Select Difficulty"),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: <Widget>[
                  const SizedBox(width: 0.0),
                  ActionChip(
                    label: const Text("Easy"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "easy" ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("easy"),
                  ),
                  ActionChip(
                    label: const Text("Medium"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "medium" ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("medium"),
                  ),
                  ActionChip(
                    label: const Text("Hard"),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: _difficulty == "hard" ? Colors.indigo : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("hard"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            processing ? const CircularProgressIndicator() : ElevatedButton(
              onPressed: _startQuiz,
              child: const Text("Start Quiz"),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      );
  }

  _selectNumberOfQuestions(int i) {
    setState(() {
      _noOfQuestions = i;
    });
  }

  _selectDifficulty(String s) {
    setState(() {
      _difficulty=s;
    });
  }

  void _startQuiz() async {
    setState(() {
      processing=true;
    });
    try {
      List<Question> questions =  await getQuestions(widget.category, _noOfQuestions, _difficulty);
      Navigator.pop(context);
      if(questions.length < 1) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const ErrorPage(message: "There are not enough questions in the category, with the options you selected.",)
        ));
        return;
      }
      if(!musicPlaying) {
        FlameAudio.bgm.play("lobby-sound.mp3");
        musicPlaying = true;
        print("Lobby sound played");
      }
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => QuizPage(questions: questions, category: widget.category, difficulty: _difficulty,
          musicPlaying: musicPlaying,)
      ));
    } on SocketException catch (_) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => const ErrorPage(message: "Can't reach the servers, \n Please check your internet connection.",)
      ));
    } catch(e){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => const ErrorPage(message: "Unexpected error trying to connect to the API",)
      ));
    }
    setState(() {
      processing=false;
    });
  }
}