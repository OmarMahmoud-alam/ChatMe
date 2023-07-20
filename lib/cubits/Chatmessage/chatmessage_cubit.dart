import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:project3/module/messagemodel.dart';
import 'package:project3/module/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:project3/util/firebasehelper.dart';

part 'chatmessage_state.dart';

class ChatmessageCubit extends Cubit<ChatmessageState> {
  ChatmessageCubit() : super(ChatmessageInitial()) {
    isopennow(receiverId: FirebaseAuth.instance.currentUser!.uid);
  }
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List<MassageModel> massages = [];
  var firestorage = firebase_storage.FirebaseStorage.instance;

  var picker = ImagePicker();
  late String otheruId;
  void getallmassage(otheruid) {
    emit(SocialGetMessagesintialState());
    otheruId = otheruid;
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
      // print("www.ssssssdumsma=" + event.docs[0].toString());
      massages = [];
      for (var element in event.docs) {
        var temp = element.data();

        massages.add(MassageModel.fromJson(temp));
      }

      emit(SocialGetMessagesSuccessState());
    });
  }

  Future<void> sendTextMessage({
    required SocialUserModel receiver,
    required int dateTime,
    required String text,
  }) async {
    MassageModel model = MassageModel(
      text: text,
      senduid: uid,
      receiveid: receiver.uId,
      datetime: dateTime,
      type: 'textmessage',
    );

    // set my chats
    emit(SocialSendMessageIntialState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiver.uId)
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
        .doc(receiver.uId)
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailState());
    });

    bool? isconeect = await getlastseen(receiverId: receiver.uId);
    if ((isconeect == null || !isconeect|| receiver.differenttime())) {
      FirebaseHelper.sendPushNotification(
          receiver.token[receiver.token.length - 1]!,
          'massage from username',
          text);
    }
  }

  @override
  Future<void> close() async {
    print('MyBloc is being closed');
    sendlastseen(
      receiverId: otheruId,
      dateTime: DateTime.now().millisecondsSinceEpoch,
    );
    await super.close();
  }

  void sendlastseen({
    required String receiverId,
    required int dateTime,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .collection('lastseen')
        .add({'lastseen': dateTime})
        .then((value) {})
        .catchError((error) {});
  }

  Future<bool?> getlastseen({
    required String receiverId,
  }) async {
    emit(SocialLastseenIntialState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverId)
        .collection('lastseen')
        // .add({'lastseen': dateTime})
        .get()
        .then((value) {
      return value.docs[0].data()['lastseen'] == -1;
    }).catchError((error) {
      emit(SocialLastseenFailState());
      return false;
    });
    return null;
  }

  void isopennow({
    required String receiverId,
  }) {
    emit(SocialLastseenIntialState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .collection('lastseen')
        .add({'lastseen': -1}).then((value) {
      emit(SocialLastseenSuccessState());
    }).catchError((error) {
      emit(SocialLastseenFailState());
    });
  }

  Future<void> sendimageMessage({
    required String receiverId,
    required int dateTime,
    required String text,
  }) async {
    MassageModel model = MassageModel(
      text: text,
      senduid: uid,
      receiveid: receiverId,
      datetime: dateTime,
      type: 'Image',
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

  Future<String> uploadpicture(File profileImage) async {
    emit(Uploadimageinitalstate());
    String link = 'something wrong';
    await firestorage
        .ref()
        .child('chat/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) {
        link = value.toString();

        return value.toString();
      }).catchError((e) {
        emit(Uploadimageerrorstate());
        return e.toString();
      });
    }).catchError((e) {
      print('t22$e');
    });
    return link;
  }

  Future<bool?> isactivechatuser(receiverId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .collection('lastseen')
        .get()
        .then((value) {
      var val = value.docs[0].data();
      emit(SocialLastseenSuccessState());
      return (val == -1);
    }).catchError((error) {
      emit(SocialLastseenFailState());
      return false;
    });
    return null;
  }

  Future<void> SendImagemassage(ImageSource source, String receiverId) async {
    emit(PickimageMassegeIntailState());

    final pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      var profileImage = File(pickedFile.path);
      print(pickedFile.path);
      String link = await uploadpicture(profileImage);
      print('e33$link');
      await sendimageMessage(
          receiverId: receiverId,
          dateTime: DateTime.now().millisecondsSinceEpoch,
          text: link);
      emit(PickimageMassegeSuccessState());
    } else {
      print('No image selected.');
      emit(PickimageMassegeNoimageState());
    }
  }
}
