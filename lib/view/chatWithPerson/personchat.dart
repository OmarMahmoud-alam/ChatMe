import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/Chatmessage/chatmessage_cubit.dart';
import 'package:project3/module/messagemodel.dart';
import 'package:project3/module/user.dart';
import 'package:project3/view/call/callbutton.dart';
import 'package:project3/view/chatWithPerson/messagewidgets.dart';
import 'package:project3/widget/sharedwidget.dart';

class ChatDetails extends StatelessWidget {
  final TextEditingController massagecontroller = TextEditingController();
  final SocialUserModel? user;

  ChatDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatmessageCubit()
        ..getallmassage(user!.uId)
        ..getme()
        ..isopennow(receiverId: user!.uId),
      child: BlocConsumer<ChatmessageCubit, ChatmessageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final blocprovider = BlocProvider.of<ChatmessageCubit>(context);

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60.0,
              leading: IconButton(
                onPressed: () {
                  //     blocprovider.pickImage(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: Row(
                children: [
                   CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        user!.cover!,
                      )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      user!.name ?? 'anayomis',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              actions: [
                const SizedBox(
                  width: 10,
                ),
                CallButton(inviteduser: user!, isVideocall: true),
                CallButton(inviteduser: user!, isVideocall: false),
                /* IconButton(
                    onPressed: () {
                      if (blocprovider.caller!.uId.compareTo(user!.uId) != 0 ||
                          blocprovider.caller != null) {
                        navigateto(
                            context: context,
                            widget: CallEndToEnd(
                              user: user!,
                            ));
                      } else {
                        toast(txt: 'you can\'t call youself');
                      }
                    },
                    icon: const Icon(Icons.call)),*/
                const SizedBox(
                  width: 14,
                ),
                const Icon(Icons.three_p_rounded),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: Column(
              children: [
                // const Spacer(),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          MassageModel tempmassage =
                              blocprovider.massages[index];
                          if (tempmassage.senduid == user!.uId) {
                            return othermassage(
                              type: tempmassage.type,
                              text: tempmassage.text,
                            );
                          }
                          return mymassage(
                            text: tempmassage.text,
                            type: tempmassage.type,
                          );
                        },
                        separatorBuilder: (context, index) => Container(),
                        itemCount: blocprovider.massages.length)),

                //  Text('sdasdasdasda')

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: 55,
                    child: Row(
                      children: [
                        Expanded(
                          child: defaultFormField(
                            prefix: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        // <-- SEE HERE
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10.0),
                                        ),
                                      ),
                                      builder: (BuildContext bc) {
                                        return imagepackerform(
                                          userid: user!.uId,
                                          blocprovid: blocprovider,
                                        );
                                      });
                                }, //=> blocprovider.pickImage(),
                                icon: const Icon(Icons.add)),
                            hint: 'type the text here......',
                            controller: massagecontroller,
                            type: TextInputType.text,
                            validate: (String? s) {
                              if (s == null || s == '') {
                                return 'must enter value';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            height: 55,
                            child: IconButton(
                                onPressed: () {
                                  if (massagecontroller.text.trimLeft() != '') {
                                    blocprovider.sendTextMessage(
                                        receiver: user!,
                                        dateTime: DateTime.now()
                                            .millisecondsSinceEpoch,
                                        text: massagecontroller.text);
                                    massagecontroller.text = '';
                                  }
                                },
                                icon: const Icon(Icons.send_outlined)))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
