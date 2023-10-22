import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_cubit/social_cubit.dart';
import 'package:social_app/social_cubit/social_states.dart';

class EditProfileScreen extends StatelessWidget
{
  var nameController =TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text= userModel!.name!;
        phoneController.text= userModel.phone!;
        bioController.text= userModel.bio!;


        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Text(
              'Edit Profile',
            ),
            actions:
            [
              TextButton(
                onPressed: ()
                {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                  );
                },
                child: Text(
                  'Update',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
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
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children:[
                              Container(
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
                                  image: coverImage ==null ? NetworkImage(
                                    '${userModel.cover}',
                                  ) : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                              IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon:CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16.0,
                                    ),
                                  ),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,

                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,

                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:  profileImage == null ? NetworkImage(
                                  '${userModel.image}',
                                ) : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon:CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                  Row(
                    children:
                    [
                      if (SocialCubit.get(context).profileImage != null)
                  Expanded(
                        child: OutlinedButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).uploadProfileImage(
                              name:nameController.text ,
                              phone: phoneController.text,
                              bio: bioController.text,
                            );
                          },
                          child: Text(
                            'Upload Profile',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      if (SocialCubit.get(context).coverImage != null)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).uploadCoverImage(
                              name:nameController.text ,
                              phone: phoneController.text,
                              bio: bioController.text,
                            );
                          },
                          child: Text(
                            'Upload Cover',
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                  SizedBox(
                  height: 10.0,
                ),
                  TextFormField(
                    controller: nameController,
                    keyboardType:TextInputType.name,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return'please enter your name';
                      }
                      return null ;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon:Icon(
                        Icons.person,
                      ) ,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType:TextInputType.phone,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return'please enter your phone';
                      }
                      return null ;
                    },
                    decoration: InputDecoration(
                      labelText: 'phone',
                      prefixIcon:Icon(
                        Icons.phone,
                      ) ,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType:TextInputType.text,
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return'please enter your bio';
                      }
                      return null ;
                    },
                    decoration: InputDecoration(
                      labelText: 'bio',
                      prefixIcon:Icon(
                        Icons.info_outline,
                      ) ,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
