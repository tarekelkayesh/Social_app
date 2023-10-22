import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit_shop.dart';
import 'package:social_app/cubit/states_shop.dart';
import 'package:social_app/modules/search/search_screen.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions:
            [
              IconButton(onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SearchScreen(),),
                );
              },
                icon: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(

            onTap:(index)
            {
              cubit.changeBottom(index);
            } ,
            currentIndex: cubit.currentIndex,
            items:
            [
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.home,
                ),
                label:'Home',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.apps,
                ),
                label:'Categories',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.favorite,
                ),
                label:'Favorites',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.settings,
                ),
                label:'Settings',
              ),

            ],
          ),
        );
      },

    );
  }
}
