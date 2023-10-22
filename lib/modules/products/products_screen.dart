import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubit/cubit_shop.dart';
import 'package:social_app/cubit/states_shop.dart';
import 'package:social_app/models/cateogories_model.dart';
import 'package:social_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state)
        {
          if (state is ShopSuccessChangeFavoritesState)
          {
            if (!state.model.status!)
            {

              Fluttertoast.showToast(
                  msg: state.model.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
       builder : (context,state)
        {
         return ConditionalBuilder(
              condition:ShopCubit.get(context).homeModel !=null
                  && ShopCubit.get(context).categoriesModel !=null,
              builder:(context)=> builderWidget(ShopCubit.get(context).homeModel !,
                  ShopCubit.get(context).categoriesModel ! ,context),
            fallback:(context)=> Center(child: CircularProgressIndicator()),
               );
        },
    );
  }
  Widget builderWidget (HomeModel model,CategoriesModel  categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: model .data!.banners.map((e) =>
            Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),

          ).toList(),
          options:CarouselOptions
            (
            height: 200.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn ,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Wrap(
                spacing: 10.0,
                  runSpacing: 5.0,
                  children: List.generate(
                      categoriesModel.data!.data.length,
                          (index) => buildCategoryItem(categoriesModel.data!.data[index]),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount:2,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1/1.7,
            children: List.generate(
              model.data!.products.length,
                    (index) =>buildGridProduct(model.data!.products[index],context),
            ),

          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model) => Column(
    children:
    [
      Chip(
          label: Text(
        model.name!,
          ),
           avatar: CircleAvatar(
          backgroundImage: NetworkImage(
            model.image!,
          ),
        ),
      ),
    ],
  );
  Widget buildGridProduct(ProductsModel model, context) =>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage(model.image!),
             width: double.infinity,
              height: 200.0,
            ),
            if(model.discount !=0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5.0,),

              child:Text(
                'OFFER',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount !=0)
                  Text(
                    '${model.oldprice.round()}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id!);
                        print(model.id);
                      },
                      icon:CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.id]! ?Colors.red : Colors.grey ,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
