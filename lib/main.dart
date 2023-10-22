import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/cubit_shop.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/remote/bloc_observer.dart';
import 'package:social_app/remote/cache_helper.dart';
import 'package:social_app/remote/components.dart';
import 'package:social_app/remote/dio_helper.dart';
import 'package:social_app/social_cubit/social_cubit.dart';
import 'package:social_app/social_layout.dart';
import 'package:social_app/social_modules/social_login.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler (RemoteMessage message)async
{
  print(message.data.toString());
}

void main ()async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  var token = await FirebaseMessaging.instance.getToken();

  print(token);

  FirebaseMessaging.onMessage.listen((event)
  {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler);


  Bloc.observer = MyBlocObserver();
  DioHelper.init();
await  CacheHelper.init();

Widget widget;

// bool? onBoarding = CacheHelper.getData(key:'onBoarding');
 //token = CacheHelper.getData(key:'token');
   uId = CacheHelper.getData(key:'uId');

  // ignore: unnecessary_null_comparison
 // if(onBoarding != null)
  //  {
      // ignore: unnecessary_null_comparison
   //   if (token != null) widget =ShopLayout();
    //  else widget = ShopLoginScreen();
   // }else
   // {
    //  widget =OnBoardingScreen();
   // }

  if(uId !=null)
  {
    widget =SocialLayout();
  }else
  {
    widget=SocialLoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget? startWidget;
  MyApp({
      this.startWidget
});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
      BlocProvider(
        create: (BuildContext context)=>AppCubit(),
      ),
        BlocProvider(
          create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            theme:ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize:20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                elevation: 20.0,
              ),
            ),
            home:startWidget,
          );
        },
      ),
    );

  }
}

