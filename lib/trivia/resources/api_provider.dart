import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triviabattlegame/trivia//models/category.dart';
import 'package:triviabattlegame/trivia//models/question.dart';

const String baseUrl = "https://opentdb.com/api.php";

Future<List<Question>> getQuestions(Category category, int total, String difficulty) async {
  http.Response res = await http.get(Uri.parse(
      "$baseUrl?amount=$total&category=${category.id}&difficulty=$difficulty"));

  /*String url = "$baseUrl?amount=$total&category=${category.id}";
  if(difficulty != null) {
    url = "$url&difficulty=$difficulty";
  }
  http.Response res = await http.get(url);*/

  List<Map<String, dynamic>> questions = List<Map<String,dynamic>>.from(json.decode(res.body)["results"]);
  return Question.fromData(questions);
}