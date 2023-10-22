import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_cubit/social_register_cubit.dart';
import 'package:social_app/social_cubit/social_register_states.dart';
import 'package:social_app/social_layout.dart';

class SocialRegisterScreen extends StatelessWidget
{

  var formKey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var passwordController = TextEditingController();
  var emailController =TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context,state)
        {
          if (state is SocialCreateUserSuccessState)
          {
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder:(context) => SocialLayout(),
              ),
                  (Route<dynamic>route) =>false,
            );
          }
        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Register now to communicate with friends ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
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
                            labelText: 'User name',
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
                              return'please enter your email address';
                            }
                            return null ;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon:Icon(
                              Icons.email_outlined,
                            ) ,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType:TextInputType.visiblePassword,
                          obscureText:true ,
                          onFieldSubmitted: (value) {},
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return'please enter your password';
                            }
                            return null ;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon:Icon(
                              Icons.lock_outline,
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
                              return'please enter your phone';
                            }
                            return null ;
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon:Icon(
                              Icons.phone,
                            ) ,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! SocialRegisterLoadingState,
                          builder: (context)=> Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                   email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                                }
                              },
                              child: Text(
                                'Register',style: TextStyle(
                                color: Colors.white,
                              ),
                              ),

                            ),
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
