import 'package:flutter/material.dart';
import 'package:project3/controller/signcontroller.dart';

import 'package:project3/styles/styles.dart';
import 'package:project3/view/chatWithPerson/personchat.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:provider/provider.dart';

class CallsWidget extends StatelessWidget {
  const CallsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return const personchatpar();
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
            navigateto(context: context, widget: ChatDetails(user:Comman.meuser ,));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: Image.asset('assets/images/Avatar2.png',
                        fit: BoxFit.fill),
                  ),
                  const SizedBox(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
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
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(
                    Icons.call_made,
                    color: Colors.blueAccent,
                  ),
                  onPressed: (){},),
                  const SizedBox(
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
          margin: const EdgeInsets.only(left: 70),
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
