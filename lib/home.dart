import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: const BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      width: double.infinity,
      child: const Text(
        'Hey we go',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
}
