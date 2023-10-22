import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states_shop.dart';
import 'package:social_app/models/cateogories_model.dart';
import 'package:social_app/models/change_favorites_model.dart';
import 'package:social_app/models/favorites_model.dart';
import 'package:social_app/models/home_model.dart';
import 'package:social_app/models/login_model.dart';
import 'package:social_app/modules/cateogries/cateogries_screen.dart';
import 'package:social_app/modules/favorites/favorites_screen.dart';
import 'package:social_app/modules/products/products_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/remote/components.dart';
import 'package:social_app/remote/dio_helper.dart';
import 'package:social_app/remote/end_point.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit () : super (ShopInitialState());
  static ShopCubit get (context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index)
  {
    currentIndex = index ;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel ;
  Map <int ,bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url:HOME,
      token:token,
    ).then((value)
    {
      homeModel =HomeModel.fromJson(value.data);
      print(homeModel!.status);

      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id! : element.infavorites!,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel ;

  void getCategories()
  {
    DioHelper.getData(
      url:GET_CATEGORIES,
      token:token,
    ).then((value)
    {
      categoriesModel =CategoriesModel.fromJson(value.data);


      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
        token: token,
    )
        .then((value) {
          changeFavoritesModel =ChangeFavoritesModel.fromJson(value.data);
          print(value.data);
          if (!changeFavoritesModel!.status!)
          {
            favorites[productId]=!favorites[productId]!;
          }else
          {
            getFavorites();
          }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {

      favorites[productId]=!favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel ;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url:FAVORITES,
      token:token,
    ).then((value)
    {
      favoritesModel =FavoritesModel.fromJson(value.data);


      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel ;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url:PROFILE,
      token:token,
    ).then((value)
    {
      userModel =ShopLoginModel.fromJson(value.data);


      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
  void getUpdateUserData({
    required String name ,
    required String email ,
    required String phone ,
})
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token:token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      userModel =ShopLoginModel.fromJson(value.data);


      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}