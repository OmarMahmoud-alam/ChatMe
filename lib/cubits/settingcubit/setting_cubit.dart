import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:project3/module/user.dart';
import 'package:project3/styles/styles.dart';
import 'package:project3/widget/sharedwidget.dart';

part 'setting_state.dart';

class Cubitsetting extends Cubit<SettingState> {
  Cubitsetting() : super(SettingInitial()) {
    usertemp = Comman.meuser;
  }

  static Cubitsetting get(context) => BlocProvider.of(context);
  SocialUserModel? usertemp;

  var picker = ImagePicker();
  File? profileImage;
  var cover;

  Future<void> uploadprofileImagemassage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      toast(txt: 'No image selected. pls select image');
      emit(SocialProfileImagePickedErrorState1());
    }
  }

  void update() {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          usertemp!.cover = value;
          updateUser();
        }).catchError((e) {
          print(e.toString());
          emit(SocialProfileImagePickedErrorState2());
        });
      });
    } else {
      updateUser();
    }
  }

  void updateshowdate({String? phone, String? bio, String? name}) {
    usertemp!.phone = phone ?? usertemp!.phone;
    usertemp!.bio = bio ?? usertemp!.bio;
    usertemp!.name = name ?? usertemp!.name;
    emit(UpdateShowuser());
  }

  void updateUser() {
    emit(SocialUserUpdateIntiaState());

    SocialUserModel modelupdate = SocialUserModel(
      email: Comman.meuser!.email,
      name: usertemp!.name,
      phone: usertemp!.phone,
      bio: usertemp!.bio,
      cover: cover ?? Comman.meuser!.cover,
      uId: Comman.meuser!.uId,
      token: [...Comman.meuser!.token],
      lastseen: -1,
    );
    print(modelupdate.tostring());
    FirebaseFirestore.instance
        .collection('users')
        .doc(Comman.meuser!.uId)
        .update(modelupdate.toMap())
        .then((value) {
      usertemp = modelupdate;
      emit(SocialUserUpdateSuccessState());

      toast(txt: 'update success');
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }
}
