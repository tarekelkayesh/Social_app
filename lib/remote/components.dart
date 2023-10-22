import 'package:flutter/material.dart';
import 'package:social_app/cubit/cubit_shop.dart';
import 'package:social_app/modules/login/shop_login_screen.dart';
import 'package:social_app/remote/cache_helper.dart';

void printFullText (String text)
{
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}


String? token ='';
String? uId ='';



void signOut (context)
{
  CacheHelper.removeData(key: 'token',).then((value)
  {
    if (value)
    {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => (
              ShopLoginScreen()
          ),
        ),
            (route) => false,
      );
    }
  });
}


Widget buildListProduct(model,context, {bool isOldPrice =true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image:NetworkImage(model.image!),
                width:120.0,
                height: 120.0,
              ),
              if(model.discount !=0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0,),

                  child:Text(
                    'OFFER',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
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
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price!.toString()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount !=0 && isOldPrice)
                    Text(
                      '${model.oldPrice!.toString()}',
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
  ),
);