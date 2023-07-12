import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';

import 'package:project3/styles/styles.dart';
import 'package:project3/view/chat/personchat.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:provider/provider.dart';

class CallsWidget extends StatelessWidget {
  const CallsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return personchatpar();
          }, childCount: 10),
        )
      ],
    );
  }
}

class personchatpar extends StatelessWidget {
  const personchatpar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider1 = Provider.of<UserProvider>(context);
    
    return Column(
      children: [
        InkWell(
          onTap: () {
            navigateto(context: context, widget: ChatDetails(user:provider1.meAsUser ,));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    child: Image.asset('assets/images/Avatar2.png',
                        fit: BoxFit.fill),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'omar mahoud',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.nametext,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.call_received,
                            color: Colors.red,
                          ),
                          Text(
                            'july 4 ,2022 at 6:42pm',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Style.masege,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                    Icons.call_made,
                    color: Colors.blueAccent,
                  ),
                  onPressed: (){},),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.2,
          color: Style.bordercolor,
          margin: EdgeInsets.only(left: 70),
        )
      ],
    );
  }
}

class firstelement extends StatelessWidget {
  const firstelement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: Style.bordercolor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //   toast(txt: "H" + constraints.maxHeight.toString());

          return Icon(
            Icons.add,
            color: Style.bordercolor,
          );
        },
      ),
    );
  }
}
