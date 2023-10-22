import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/remote/components.dart';

import '../../cubit/cubit_shop.dart';
import '../../cubit/states_shop.dart';

class FavoritesScreen extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return  ConditionalBuilder(
          condition: state is ! ShopLoadingGetFavoritesState ,
          builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
              separatorBuilder: (context,index) => Divider(height: 2,color: Colors.grey,),
              itemCount:ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
