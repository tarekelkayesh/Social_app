import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_cubit/social_cubit.dart';
import 'package:social_app/social_cubit/social_states.dart';

class NewPostScreen extends StatelessWidget
{

  var textController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state) {},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
            ),
            actions: [
              TextButton(
                onPressed: ()
                {
                  var now =DateTime.now();

                  if(SocialCubit.get(context).postImage == null)
                  {
                    SocialCubit.get(context).createPost(
                      dataTime: now.toString(),
                      text: textController.text,
                    );
                  }else
                  {
                    SocialCubit.get(context).uploadPostImage(
                      dataTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
                child: Text(
                  'Post',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children:
              [
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}',
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        'Tarek Elkayesh',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Write Post ....',
                      border:InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                if ( SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children:[
                    Container(
                      height: 150.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                          SocialCubit.get(context).removePostImage();
                      },
                      icon:CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Icon(
                                Icons.image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo',
                              ),

                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                          '# tags'
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}





