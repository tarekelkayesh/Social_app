
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states_shop_search.dart';
import 'package:social_app/models/search_model.dart';
import 'package:social_app/remote/components.dart';
import 'package:social_app/remote/dio_helper.dart';
import 'package:social_app/remote/end_point.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit (): super (SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model ;

  void search(String text)
  {
    emit(SearchLoadingState());
 DioHelper.postData(
     url: SEARCH,
     token: token,
     data:
     {
       'text': text,
     },
 ).then((value)
 {
   model =SearchModel.fromJson(value.data);
emit(SearchSuccessState());
 }).catchError((error)
 {
   print(error.toString());
   emit(SearchErrorState());
 });
  }
}