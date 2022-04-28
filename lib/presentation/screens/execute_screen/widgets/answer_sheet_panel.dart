// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AnswerSheetPanel extends StatelessWidget {
  double maxWidthForMobile;
  double currentWidth;
  double currentHeight;
  Color selectedColor;
  Color answerColor;
  Function onPressedCancel;
  Function onPressedSubmit;
  Function(int questionNumber) onPressedGoToQuestion;
  List<AnswerSheetModel> answerSheetData;
  final List<Widget> _displayList = [];

  AnswerSheetPanel({
    Key? key,
    required this.currentWidth,
    required this.currentHeight,
    required this.maxWidthForMobile,
    required this.selectedColor,
    required this.answerColor,
    required this.answerSheetData,
    required this.onPressedSubmit,
    required this.onPressedCancel,
    required this.onPressedGoToQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _displayList.clear();
    for (AnswerSheetModel answerSheetModel in answerSheetData) {
      _displayList.add(
        const Divider(height: 0.5, thickness: 1, color: Color(0x1000001B)),
      );
      _displayList.add(
        AnswerSheetItem(
            answerColor: answerColor,
            selectedColor: selectedColor,
            questionNumber: answerSheetModel.questionNumber,
            userSelectedAns: answerSheetModel.userSelectedIndex,
            correctAns: answerSheetModel.correctAnswerIndex,
            onPressed: onPressedGoToQuestion),
      );
    }
    return SizedBox(
      width: currentWidth > maxWidthForMobile ? 0.7 * maxWidthForMobile : 0.7 * currentWidth,
      height: 0.7 * currentHeight,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListBody(
                  children: _displayList,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  onPressedCancel();
                },
              ),
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  onPressedSubmit();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class AnswerSheetItem extends StatelessWidget {
  AnswerSheetItem(
      {Key? key,
      required this.questionNumber,
      required this.selectedColor,
      required this.answerColor,
      required this.userSelectedAns,
      required this.correctAns,
      this.onPressed})
      : super(key: key);

  int userSelectedAns;
  int correctAns;
  int questionNumber;
  Color selectedColor;
  Color answerColor;
  Function(int number)? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorA = correctAns == 0
        ? answerColor
        : userSelectedAns == 0
            ? selectedColor
            : Colors.transparent;
    final colorB = correctAns == 1
        ? answerColor
        : userSelectedAns == 1
            ? selectedColor
            : Colors.transparent;
    final colorC = correctAns == 2
        ? answerColor
        : userSelectedAns == 2
            ? selectedColor
            : Colors.transparent;
    final colorD = correctAns == 3
        ? answerColor
        : userSelectedAns == 3
            ? selectedColor
            : Colors.transparent;
    final colorText = (correctAns != 4 &&
            userSelectedAns != 4 &&
            userSelectedAns == correctAns)
        ? Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(color: Colors.green, fontWeight: FontWeight.bold)
        : (correctAns != 4 &&
                userSelectedAns != 4 &&
                userSelectedAns != correctAns)
            ? Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.orange, fontWeight: FontWeight.bold)
            : Theme.of(context).textTheme.headline4;
    return GestureDetector(
      onTap: () {
        onPressed!(questionNumber);
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  '$questionNumber.',
                  style: colorText,
                ),
                width: 40.0,
              ),
              AnswerBox('A', colorA),
              AnswerBox('B', colorB),
              AnswerBox('C', colorC),
              AnswerBox('D', colorD),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerBox extends StatelessWidget {
  AnswerBox(
    this.text,
    this.color, {
    Key? key,
  }) : super(key: key);

  String text;
  Color color;

  double sizeBox = 25.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeBox,
      height: sizeBox,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black12),
          borderRadius: const BorderRadius.all(Radius.circular(1000))),
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12.0),
      )),
    );
  }
}

class AnswerSheetModel {
  int questionNumber;
  int userSelectedIndex;
  int correctAnswerIndex;

  AnswerSheetModel({
    required this.questionNumber,
    this.userSelectedIndex = 4, // not answer
    this.correctAnswerIndex = 4, // not answer
  });
}
