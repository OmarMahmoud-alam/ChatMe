import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/pagecubit/pagescubit_cubit.dart';

import 'package:project3/styles/styles.dart';

class HomeChat extends StatelessWidget {
  const HomeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PagescubitCubit>(
      create: (context) => PagescubitCubit(),
      child: BlocBuilder<PagescubitCubit, PagescubitState>(
        builder: (context, state) {
          final blocprovider = BlocProvider.of<PagescubitCubit>(context);
          return Scaffold(
            backgroundColor: Style.whitecolor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Style.whitecolor,
              title: Text(
                blocprovider.title[blocprovider.pageindex],
                style: Style.headertexttheme,
              ),
              actions: blocprovider.actions[blocprovider.pageindex],
            ),
            body: blocprovider.bodies[blocprovider.pageindex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: blocprovider.pageindex,
              type: BottomNavigationBarType.fixed,
              elevation: 1,
              unselectedItemColor: Style.bordercolor,
              unselectedLabelStyle: Style.masege.copyWith(
                fontFamily: "Lato",
                fontSize: 12,
              ),
              selectedItemColor: Colors.blueAccent,
              onTap: (index) {
                blocprovider.changepage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined),
                  label: "Chats",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call_missed),
                  label: "calls",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box),
                  label: "User",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
