import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:project3/module/messagemodel.dart';

import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'chatmessage_state.dart';

class ChatmessageCubit extends Cubit<ChatmessageState> {
  ChatmessageCubit() : super(ChatmessageInitial());
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<MassageModel> massages = [];

  // ClientRole? _role = ClientRole.Broadcaster;
  Future<void> handlecameraandmicro(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }

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
      event.docs.forEach((element) {
        var temp = element.data();

        massages.add(MassageModel.fromJson(temp));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required int dateTime,
    required String text,
  }) {
    MassageModel model = MassageModel(
      text: text,
      senduid: uid,
      receiveid: receiverId,
      datetime: dateTime,
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
}
