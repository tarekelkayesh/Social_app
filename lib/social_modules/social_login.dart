import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/remote/cache_helper.dart';
import 'package:social_app/social_cubit/social_login_cubit.dart';
import 'package:social_app/social_cubit/social_login_states.dart';
import 'package:social_app/social_layout.dart';
import 'package:social_app/social_modules/social_register.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SocialLoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var emailController =TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(BuildContext  context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context ,state)
        {
          if (state is SocialLoginErrorState)
          {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if (state is SocialLoginSuccessState)
          {
            CacheHelper.saveDate(
              key: 'uId',
              value:state.uId,
            ).then((value){

              Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder:(context) => SocialLayout(),
                ),
                    (Route<dynamic>route) =>false,
              );
            });
          }
        },
        builder: (context ,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'login now to communicate with friends ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
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
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType:TextInputType.visiblePassword,
                          obscureText:true ,
                          onFieldSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                                SocialLoginCubit.get(context).userLogin(
                                 email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
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
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState ,
                          builder: (context)=> Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                      SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                   password: passwordController.text,
                                  );
                                }
                              },
                              child: Text(
                                'LOGIN',style: TextStyle(
                                color: Colors.white,
                              ),
                              ),

                            ),
                          ),
                          fallback: (context)=>Center(
                              child: CircularProgressIndicator()

                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don\t have an account?'),
                            TextButton(
                              onPressed: ()
                              {
                                Navigator.push(context,
                                  MaterialPageRoute
                                    (builder:(context) => SocialRegisterScreen(),
                                  ),
                                );
                              },
                              child:Text(
                                'Register',
                              ),
                            ),
                          ],
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
