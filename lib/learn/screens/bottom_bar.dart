import 'package:flutter/material.dart';

class bottombar extends StatefulWidget {
  const bottombar({super.key});

  @override
  State<bottombar> createState() => _bottombarState();
}

class _bottombarState extends State<bottombar> {
  int _indexbottom = 2;

  void _ontapbottom(int index) {
    setState(() {
      _indexbottom = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("my app"),
      ),
      body: const Center(child: Text('my body')),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _ontapbottom,
        currentIndex: _indexbottom,
        backgroundColor: const Color.fromARGB(255, 52, 212, 37),
        elevation: 10,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 30),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedLabelStyle: const TextStyle(
            color: Color.fromRGBO(211, 40, 10, 0.612), fontSize: 10),
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_outlined),
              activeIcon: Icon(Icons.airplane_ticket_rounded),
              label: 'ticket'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
    );
  }
}
