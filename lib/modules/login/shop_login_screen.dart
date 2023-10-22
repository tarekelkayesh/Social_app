import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubit/cubit_shop_login.dart';
import 'package:social_app/cubit/states_shop_login.dart';
import 'package:social_app/modules/register/shop_register_screen.dart';
import 'package:social_app/remote/cache_helper.dart';
import 'package:social_app/remote/components.dart';
import 'package:social_app/shop_layout.dart';

class ShopLoginScreen extends StatefulWidget
{
  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController =TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state)
        {
          if (state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveDate(
                key: 'token',
                value:state.loginModel.data!.token,
              ).then((value){
                token =state.loginModel.data!.token;
                Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder:(context) => ShopLayout(),
                  ),
                      (Route<dynamic>route) =>false,
                );
              });
            }else
            {
              print(state.loginModel.message);

              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
        builder: (context,state)
        {
          return  Scaffold(
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
                          'login now to browse our hot offers',
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
                              ShopLoginCubit.get(context).userLogin(
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
                          condition: state is! ShopLoginLoadingState ,
                          builder: (context)=> Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
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
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
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
                                    (builder:(context) => ShopRegisterScreen(),
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
