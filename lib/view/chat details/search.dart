import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project3/styles/styles.dart';
import 'package:project3/view/chat/personchat.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:project3/widget/widgets.dart';

class SearchWidgets extends StatelessWidget {
  SearchWidgets({
    super.key,
  });
  final TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          // toolbarHeight: 53,
          flexibleSpace: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5,
            ),
            width: double.infinity,
            // height: 90,
            child: defaultFormField(
              border: const OutlineInputBorder(
                gapPadding: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              hint: 'search',
              fillcolor: Style.bordercolor,
              prefix: Icons.search,
              controller: searchcontroller,
              type: TextInputType.text,
              validate: (String? value) {},
            ),
          ),
        ),
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
    return Column(
      children: [
        InkWell(
          onTap: () {
            navigateto(context: context, widget: ChatDetails());
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
                        height: 5,
                      ),
                      Text(
                        'this my massage',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.masege,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        '3m ago',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.nametext,
                      ),
                      Spacer()
                    ],
                  ),
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
