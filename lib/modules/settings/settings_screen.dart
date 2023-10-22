import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit_shop.dart';
import 'package:social_app/cubit/states_shop.dart';
import 'package:social_app/remote/components.dart';

class SettingsScreen extends StatelessWidget
{
  var formKey =GlobalKey<FormState>();
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        var model =ShopCubit.get(context).userModel;

        nameController.text= model!.data!.name!;
        emailController.text= model.data!.email!;
        phoneController.text= model.data!.phone!;


        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
          builder: (context)=>
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(

                     padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key: formKey,
                     child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(
                      'UPDATE',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                    height: 50.0,
                  ),
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType:TextInputType.name,
                      validator: ( value)
                      {
                        if(value!.isEmpty)
                        {
                          return'name must not be empty';
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
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType:TextInputType.emailAddress,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return'email must not be empty';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon:Icon(
                          Icons.email,
                        ) ,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType:TextInputType.phone,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return'phone must not be empty';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: ' Phone',
                        prefixIcon:Icon(
                          Icons.phone,
                        ) ,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: ()
                        { if (formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).getUpdateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                        },
                        child: Text(
                          'UPDATE',style: TextStyle(
                          color: Colors.white,
                        ),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: ()
                        {
                          signOut(context);
                        },
                        child: Text(
                          'LOGOUT',style: TextStyle(
                          color: Colors.white,
                        ),
                        ),

                      ),
                    ),
                  ],
                ),
                   ),
                 ),
              ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
