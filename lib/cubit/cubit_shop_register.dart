import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states_shop_register.dart';
import 'package:social_app/models/login_model.dart';
import 'package:social_app/remote/dio_helper.dart';

import '../remote/end_point.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit(): super (ShopRegisterInitialState());

  static ShopRegisterCubit get (context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister ({
    required String name,
    required String email ,
    required String password ,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

}
