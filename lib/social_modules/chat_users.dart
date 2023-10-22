import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_cubit/social_cubit.dart';
import 'package:social_app/social_cubit/social_states.dart';
import 'package:social_app/social_models/social_user_model.dart';
import 'package:social_app/social_modules/chat_screen.dart';

class ChatsUsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return  ConditionalBuilder(
          condition:SocialCubit.get(context).users.length >0,
          builder: (context) =>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index) => buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index) => Divider(
              height: 1,
            ),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
  Widget buildChatItem (SocialUserModel model,context)=> InkWell(
    onTap: ()
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  ChatScreen(
            userModel: model,
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children:
        [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
