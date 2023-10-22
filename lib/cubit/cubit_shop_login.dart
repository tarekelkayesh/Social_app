import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states_shop_login.dart';
import 'package:social_app/models/login_model.dart';
import 'package:social_app/remote/dio_helper.dart';
import 'package:social_app/remote/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit(): super (ShopLoginInitialState());

  static ShopLoginCubit get (context) => BlocProvider.of(context);

ShopLoginModel? loginModel;

  void userLogin ({
    required String email ,
    required String password ,

  })
  {
    emit(ShopLoginLoadingState());
DioHelper.postData(
  url: LOGIN,
  data: {
    'email':email,
    'password':password,
  },
).then((value) {
  print(value.data);
 loginModel = ShopLoginModel.fromJson(value.data);
  emit(ShopLoginSuccessState(loginModel!));
}).catchError((error)
{
  emit(ShopLoginErrorState(error.toString()));
});
  }

}
