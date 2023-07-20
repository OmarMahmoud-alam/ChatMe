import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project3/styles/styles.dart';

class LifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // Get the current time and format it
      final now = DateTime.now().millisecondsSinceEpoch;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Comman.meuser!.uId)
          .update({'lastseen': now});
    }
  }
}
