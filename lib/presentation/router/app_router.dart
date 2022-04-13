import 'package:flutter/material.dart';
import 'package:flutter_toeic_quiz2/core/exceptions/route_exception.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/execute_screen/part_one_screen/part_one_screen.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/execute_screen/part_three_screen/part_three_screen.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/execute_screen/part_two_screen/part_two_screen.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter_toeic_quiz2/presentation/router/screen_arguments.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/part_screen/part_screen.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/test_screen/test_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String test = '/tests';
  static const String part = '/parts';
  static const String part1Exam = '/part1exam';
  static const String part2Exam = '/part2exam';
  static const String part3Exam = '/part3exam';
  static const String part4Exam = '/part4exam';
  static const String part5Exam = '/part5exam';
  static const String part6Exam = '/part6exam';
  static const String part7Exam = '/part7exam';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case test:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => TestScreen(bookId: args.id, bookTitle: args.title),
        );
      case part:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => PartScreen(testId: args.id, testTitle: args.title),
        );
      case part1Exam:
      case part2Exam:
      case part3Exam:
      case part4Exam:
      case part5Exam:
      case part6Exam:
      case part7Exam:
        return onGeneratePartRoute(settings);
      default:
        throw const RouteException('Route not found!');
    }
  }

  static Route<dynamic> onGeneratePartRoute(RouteSettings settings) {
    switch (settings.name) {
      case part1Exam:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => PartOneScreen(partId: args.id, partTitle: args.title),
        );
      case part2Exam:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => PartTwoScreen(partId: args.id, partTitle: args.title),
        );
      case part3Exam:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => PartThreeScreen(partId: args.id, partTitle: args.title),
        );
      // part 3 4 5 6 7 here
      default:
        throw const RouteException('Route not found!');
    }
  }
}
