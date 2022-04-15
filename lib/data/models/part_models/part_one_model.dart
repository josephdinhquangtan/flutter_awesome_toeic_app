import 'answer_enum.dart';

class PartOneModel {
  final int questionNumber;
  final int numOfQuestion;
  final String imageUrl;
  final String soundUrl;
  final List<String> answers;
  final Answer correctAnswer;

  PartOneModel({
    required this.questionNumber,
    required this.numOfQuestion,
    required this.imageUrl,
    required this.soundUrl,
    required this.answers,
    required this.correctAnswer,
  });
}
