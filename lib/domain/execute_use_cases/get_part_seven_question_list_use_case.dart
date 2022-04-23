import 'package:flutter_toeic_quiz2/data/models/part_models/part_seven_model.dart';
import 'package:flutter_toeic_quiz2/data/repositories/execute_repository/part_seven_repository/part_seven_repository.dart';

class GetPartSevenQuestionListUserCase {
  PartSevenRepository repository;

  GetPartSevenQuestionListUserCase({required this.repository});

  Future<List<PartSevenModel>> getContent() {
    return Future.value(repository.getPartSevenQuestionList());
  }
}