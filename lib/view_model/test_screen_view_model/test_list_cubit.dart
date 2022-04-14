import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/dataproviders/test_api.dart';
import '../../data/models/test_info_model.dart';
import '../../data/repositories/test_repository/test_repository_impl.dart';
import '../../domain/base_use_case.dart';
import '../../domain/get_list_test_use_case.dart';

part 'test_list_state.dart';

class TestListCubit extends Cubit<TestListState> {
  final BaseUseCase useCase = GetListTestUseCase(repository: TestRepositoryImpl(api: TestApi()));

  TestListCubit() : super(TestListInitial());

  Future<void> getTestList() async {
    emit(TestListLoading());
    try {
      final List<TestInfoModel> testList = await useCase.getListInfo();
      emit(TestListLoaded(
        testListModel: testList,
      ));
    } catch (error) {
      emit(Failure());
    }
  }
}