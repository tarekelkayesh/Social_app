import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/social_cubit/social_register_states.dart';
import 'package:social_app/social_models/social_user_model.dart';



class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit(): super (SocialRegisterInitialState());

  static SocialRegisterCubit get (context) => BlocProvider.of(context);



  void userRegister ({
    required String name,
    required String email ,
    required String password ,
   required String phone,
  })
  {
    emit(SocialRegisterLoadingState());
        FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value) {
          userCreate(
            uId: value.user!.uid,
            phone: phone,
            email: email,
            name: name,
          );
        })
            .catchError((error){
              emit(SocialRegisterErrorState(error.toString()));
        });
  }


  void userCreate ({
    required String name,
    required String email ,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model =SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      cover: 'https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-36129.jpg?w=900&t=st=1696940433~exp=1696941033~hmac=6e6c319b8812fc0c5ffc6d7cb4d05664f3ad080f430c19a7324a1d89639d98e4',
      image: 'https://img.freepik.com/premium-photo/handsome-man-isolated-blue_1368-109046.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

}
