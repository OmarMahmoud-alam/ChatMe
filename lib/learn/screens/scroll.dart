import 'package:flutter/material.dart';

class bottomba extends StatelessWidget {
  int _indexbottom = 2;

  bottomba({super.key});

  void _ontapbottom(int index) {
    _indexbottom = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("me here"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text('das',st),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item $index"));
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item $index"));
                  }),
            ),
          ],
        ),
      ),
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
