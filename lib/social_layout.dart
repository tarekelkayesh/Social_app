import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/social_cubit/social_cubit.dart';
import 'package:social_app/social_cubit/social_states.dart';
import 'package:social_app/social_modules/new_post.dart';

class SocialLayout  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      {
        if (state is SocialNewPostState)
        {
          Navigator.push(
                context,
               MaterialPageRoute(builder: (context) =>  NewPostScreen(),),
              );
        }
      },
      builder: (context,state)
      {
        var cubit = SocialCubit.get(context);

        return  Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
            ),
            actions:
            [
              IconButton(onPressed: () {},
                icon: Icon(
                  Icons.notifications_none_outlined,
                ),
              ),
              IconButton(onPressed: ()
              {
                //  Navigator.push(
                //  context,
                // MaterialPageRoute(builder: (context) =>  SearchScreen(),),
                //);
              },
                icon: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body:cubit.screens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(

            onTap:(index)
            {
              cubit.changeBottomNav(index);
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
                  Icons.chat,
                ),
                label:'Chats',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.upload_file_outlined,
                ),
                label:'Post',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.location_on_outlined,
                ),
                label:'Users',
              ),
              BottomNavigationBarItem(
                icon:Icon(
                  Icons.settings,
                ),
                label:'Settings',
              ),

            ],
            type:  BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            backgroundColor: Colors.white,
          ),
        );

      },

    );
  }
}
