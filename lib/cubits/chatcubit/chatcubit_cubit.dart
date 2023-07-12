import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project3/module/messagemodel.dart';
import 'package:project3/module/user.dart';

part 'chatcubit_state.dart';

class ChatcubitCubit extends Cubit<ChatcubitState> {
  ChatcubitCubit() : super(ChatcubitInitial());

  final _auth = FirebaseAuth.instance;
  static ChatcubitCubit get(context) => BlocProvider.of(context);
  User? user;
  String? uid;

  void getUserData(context) {
    emit(SocialGetUserLoadingState());
    //   if (name != null) print(name);
    //  uId = CacheHelper.getData(key: 'UserUid');
    user = _auth.currentUser;
    if (user != null) {
      uid = user!.uid;
      // Do something with the uid
    }
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      //print(value.data());
      if (value.data() != null) {
        var userModel = SocialUserModel.fromJson(value.data()!);
        print(userModel.name);
      } else {
        //   navigateto(context: context, widget: HomeChat());
      }

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserFailState());
    });
  }

  void getuserFriends() {
    usersfriends = [];
    emit(SocialGetallUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid!)
        .collection('friends')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uid) {
          usersfriends.add(SocialUserModel.fromJson(element.data()));
        }
      });
    }).catchError((e) {});
  }

  List<SocialUserModel> allusers = [];
  void getalluser() {
    allusers = [];
    emit(SocialGetallUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uid) {
          allusers.add(SocialUserModel.fromJson(element.data()));
          emit(SocialGetallUsersuccessState());
        }
      });
    }).catchError((e) {
          emit(SocialGetallUserfailState());


    });
  }

//get friends only

  List<SocialUserModel> usersfriends = [];

  void setuserFriends(SocialUserModel frienduser) {
    emit(SocialGetUserFriendsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid!)
        .collection('friends')
        .add(frienduser.toMap())
        .then((value) {
      //  SocialUserModel.fromJson(element.data());
      emit(SocialGetUserFriendsSucceddState());
    }).catchError((e) {
      emit(SocialGetUserFriendsFaileddState());
    });
  }


}
