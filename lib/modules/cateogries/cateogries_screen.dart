import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit_shop.dart';
import 'package:social_app/cubit/states_shop.dart';
import 'package:social_app/models/cateogories_model.dart';

class CategoriesScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,index){},
      builder: (context,index)
      {
        return  ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) =>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index) => Divider(height: 2,color: Colors.grey,),
            itemCount:ShopCubit.get(context).categoriesModel!.data!.data.length
        );
      },
    );
  }
  Widget buildCatItem(DataModel model) =>  SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          Image(
            image:NetworkImage(model.image!),
            width: 80.0,
            height: 80.0,

          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name!,
            style:TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ) ,
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    ),
  );
}
