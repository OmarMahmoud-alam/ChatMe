import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:project3/module/user.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  String convertToLastseen(int lastSeen) {
    if (lastSeen != -1) {
      DateTime lastSeenDateTime = DateTime.fromMillisecondsSinceEpoch(lastSeen);

      final now = DateTime.now();
      final difference = now.difference(lastSeenDateTime);

      // If the last seen datetime is today, return the time
      if (now.year == lastSeenDateTime.year &&
          now.month == lastSeenDateTime.month &&
          now.day == lastSeenDateTime.day) {
        return 'Last seen ${DateFormat.jm().format(lastSeenDateTime)}';
      }

      // Otherwise, return the date
      if (difference.inDays < 7) {
        return 'Last seen ${DateFormat('EEEE').format(lastSeenDateTime)}';
      } else {
        return 'Last seen ${DateFormat('MMM d, y').format(lastSeenDateTime)}';
      }
    } else {
      return 'is active now';
    }
  }


  final _auth = FirebaseAuth.instance;
  static ChatcubitCubit get(context) => BlocProvider.of(context);
  User? user;
  String? uid;
  List<SocialUserModel> allusers = [];

  void getUserData() {
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

  
  void getalluser() {
    allusers = [];
    emit(SocialGetallUserLoadingState());
    print('hi how are you');
    FirebaseFirestore.instance.collection('users').
    where('email',).get().then((value) {
      for (var element in value.docs) {
        print(element.data()['uId']);
        if (element.data()['uId'] != uid) {
          allusers.add(SocialUserModel.fromJson(element.data()));
          emit(SocialGetallUsersuccessState());
        }
      }
    }).catchError((e) {
      emit(SocialGetallUserfailState());
    });
  }










}
