import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_cubit/social_cubit.dart';
import 'package:social_app/social_cubit/social_states.dart';
import 'package:social_app/social_modules/edit_profile.dart';
import 'package:social_app/social_modules/new_post.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
      builder: (context,state)
      {
        var userModel =SocialCubit.get(context).userModel;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:
              [
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children:
                    [
                      Align(
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                4.0,
                              ),
                              topRight: Radius.circular(
                                4.0,
                              ),
                            ),
                            image:DecorationImage(
                              image:  NetworkImage(
                                '${userModel!.cover}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,

                      ),
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                                    '${userModel.image}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${userModel.name}',                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${userModel.bio}',                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                ' 100',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                ' Post',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                ' 200',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                ' Photos',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                ' 10k',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                ' Followers',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                ' 5',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                ' Following',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Row(
                   children:
                   [
                     Expanded(
                       child: OutlinedButton(
                           onPressed: ()
                           {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>  NewPostScreen(),),
                             );
                           },
                           child: Text(
                             'Add Post',
                           ),
                       ),
                     ),
                     SizedBox(
                       width: 10.0,
                     ),
                     OutlinedButton(
                       onPressed: ()
                       {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) =>  EditProfileScreen(),),
                         );
                       },
                       child:Icon(
                         Icons.mode_edit_outlined,
                         size: 18.0,
                       ),
                     ),
                   ],
                 ),
               ),
              ],
            ),
          );
      },
    );
  }
}
