import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/models/search_model.dart';
import 'package:souqy/modules/search/cubit/states.dart';
import 'package:souqy/shared/components/constants.dart';
import 'package:souqy/shared/network/end_points.dart';
import 'package:souqy/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String query) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: TOKEN,
      data: {
        'text': query,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });

  }
}