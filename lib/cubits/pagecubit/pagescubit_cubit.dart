import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project3/view/chat%20details/calls.dart';
import 'package:project3/view/chat%20details/chats.dart';
import 'package:project3/view/chat%20details/search.dart';
import 'package:project3/view/chat%20details/setting.dart';

part 'pagescubit_state.dart';

class PagescubitCubit extends Cubit<PagescubitState> {
  int pageindex = 0;
  List<Widget> bodies = [
    ChatsWidgets(),
    CallsWidget(),
    SearchWidgets(),
    Settingapp()
  ];
  List<String> title = ['Chats', 'calls', 'Search page', 'setting'];
  List<List<Widget>> actions = [
    [
      Icon(
        Icons.chat_bubble_outline_sharp,
        color: Colors.black,
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.notifications_outlined,
        color: Colors.black,
      ),
      SizedBox(
        width: 10,
      ),
    ],
    [
      Icon(
        Icons.three_k,
        color: Colors.black,
      )
    ],
    [
      Icon(
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
