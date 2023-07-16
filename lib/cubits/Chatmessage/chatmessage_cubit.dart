import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:project3/module/messagemodel.dart';
import 'package:project3/module/user.dart';

part 'chatmessage_state.dart';

class ChatmessageCubit extends Cubit<ChatmessageState> {
  ChatmessageCubit() : super(ChatmessageInitial());
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<MassageModel> massages = [];
  void getallmassage(otheruid) {
    emit(SocialGetMessagesintialState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(otheruid)
        .collection('messages')
        .orderBy('datetime')
        .snapshots()
        .listen((
      event,
    ) {
      onError(e) {
        print(e);
        emit(SocialGetMessagesfailsState());
      }

      massages = [];
      for (var element in event.docs) {
        var temp = element.data();

        massages.add(MassageModel.fromJson(temp));
      }

      emit(SocialGetMessagesSuccessState());
    });
  }

  void sendTextMessage({
    required String receiverId,
    required int dateTime,
    required String text,
  }) {
    MassageModel model = MassageModel(
      text: text,
      senduid: uid,
      receiveid: receiverId,
      datetime: dateTime,
      type: 'Message',
    );

    // set my chats
    emit(SocialSendMessageIntialState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailState());
    });
  }

  SocialUserModel? caller;
  void getme() {
    emit(SocialMeintialState());
    FirebaseFirestore.instance
        .collection('users')
        .where('uId', isEqualTo: uid.toString())
        .get()
        .then((value) {
      caller = SocialUserModel.fromJson(value.docs[0].data());
      emit(SocialMesuccessState());

      print(caller!.email);
    }).catchError((e) {
      emit(SocialMeFailState());
    });
  }
}
