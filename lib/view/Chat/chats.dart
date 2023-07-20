import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/chatcubit/chatcubit_cubit.dart';
import 'package:project3/module/user.dart';

import 'package:project3/styles/styles.dart';
import 'package:project3/view/chatWithPerson/personchat.dart';
import 'package:project3/widget/sharedwidget.dart';

class ChatsWidgets extends StatelessWidget {
  const ChatsWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatcubitCubit()
        ..getUserData()
        ..getalluser()
        ..getuserFriends(),
      child: BlocConsumer<ChatcubitCubit, ChatcubitState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final blocprovider = BlocProvider.of<ChatcubitCubit>(context);

          return (blocprovider.allusers.isEmpty || blocprovider.user == null)
              ? const Center(
                  child: Text('you don\'t have friends add some friends'),
                )
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: 108.0,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15.0),
                        color: Style.messagegrey,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              ChatcubitCubit.get(context).allusers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  const firstelement(),
                                  SizedBox(
                                    width: 56,
                                    child: Text(
                                      'Pin favorite',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style:
                                          Style.nametext.copyWith(fontSize: 10),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // color: Colors.black,
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              blocprovider
                                                  .allusers[index - 1].cover!,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                        width: 56,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          blocprovider.allusers[index - 1].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Style.nametext
                                              .copyWith(fontSize: 10),
                                        ))
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Personchatpar(
                            user: blocprovider.allusers[index]);
                      }, childCount: blocprovider.allusers.length),
                    )
                  ],
                );
        },
      ),
    );
  }
}

class Personchatpar extends StatelessWidget {
  final SocialUserModel user;
  const Personchatpar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            navigateto(
                context: context,
                widget: ChatDetails(
                  user: user,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      user.cover!,
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.nametext,
                      ),
                      const Spacer(),
                      Text(
                        'this my last message massage',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.masege,
                      ),
                      const SizedBox(
                        height: 3,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        '3m ago',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.nametext,
                      ),
                      const Spacer()
                    ],
                  ),
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
