import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project3/view/Chat/calls.dart';
import 'package:project3/view/Chat/chats.dart';
import 'package:project3/view/Chat/search.dart';
import 'package:project3/view/setting/setting.dart';

part 'pagescubit_state.dart';

class PagescubitCubit extends Cubit<PagescubitState> {
  int pageindex = 0;
  List<Widget> bodies = [
    const ChatsWidgets(),
    const CallsWidget(),
    SearchWidgets(),
    const Settingapp()
  ];
  List<String> title = ['Chats', 'calls', 'Search page', 'setting'];
  List<List<Widget>> actions = [
    [
      InkWell(
        onTap: () {
          //FirebaseHelper.showNotificationWithActions();
        },
        child: const Icon(
          Icons.chat_bubble_outline_sharp,
          color: Colors.black,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      const Icon(
        Icons.notifications_outlined,
        color: Colors.black,
      ),
      const SizedBox(
        width: 10,
      ),
    ],
    [
      const Icon(
        Icons.three_k,
        color: Colors.black,
      )
    ],
    [
      const Icon(
        Icons.delete,
        color: Colors.black,
      )
    ],
    []
  ];

  PagescubitCubit() : super(PagescubitInitial());

  void changepage(index) {
    try {
      emit(PagescubitchangeIntial());
      pageindex = index;
      emit(PagescubitChangesuccess());
    } catch (e) {
      emit(PagescubitChangefail());
    }
  }
}
