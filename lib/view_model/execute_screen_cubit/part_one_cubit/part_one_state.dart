part of 'part_one_cubit.dart';

abstract class PartOneState {}

class PartOneInitial extends PartOneState {}

// load content
class PartOneLoading extends PartOneState {}

class PartOneContentLoaded extends PartOneState {
  final int currentQuestionNumber;
  final int questionListSize;
  final PartOneModel partOneModel;
  final UserAnswer userAnswer;
  final UserAnswer correctAnswer;

  PartOneContentLoaded({
    required this.currentQuestionNumber,
    required this.questionListSize,
    required this.correctAnswer,
    required this.partOneModel,
    required this.userAnswer,
  });
}

class PartOneCheckedAnswer extends PartOneState {}
