import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_cubit/social_cubit.dart';
import 'package:social_app/social_cubit/social_states.dart';
import 'package:social_app/social_models/post_model.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 ,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0,),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children:
                    [
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-36129.jpg?w=900&t=st=1696940433~exp=1696941033~hmac=6e6c319b8812fc0c5ffc6d7cb4d05664f3ad080f430c19a7324a1d89639d98e4',),
                        fit:  BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:(context,index) =>  buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index)=>SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
  Widget buildPostItem(PostModel model, context,index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,

                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style:TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              IconButton(onPressed: (){},
                icon:Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              height:1.3,
            ),
          ),
          if (model.postImage != '')
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0,),
            child: Container(
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0,
                ),
                image:DecorationImage(
                  image:  NetworkImage(
                        '${model.postImage}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children:
                        [
                          Icon(
                            Icons.favorite_border,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Icon(
                            Icons.chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            '0 comment',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image!}',
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'write a comment ...',
                        style:TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,

                        ),
                      ),
                    ],
                  ),
                  onTap:(){} ,
                ),
              ),
              InkWell(
                child: Row(
                  children:
                  [
                    Icon(
                      Icons.favorite_border,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      'Like',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                onTap: ()
                {
                    SocialCubit.get(context).likePosts(SocialCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
