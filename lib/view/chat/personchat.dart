import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/Chatmessage/chatmessage_cubit.dart';
import 'package:project3/module/messagemodel.dart';
import 'package:project3/module/user.dart';
import 'package:project3/view/call/callpage.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ChatDetails extends StatelessWidget {
  final TextEditingController massagecontroller = TextEditingController();
  final SocialUserModel? user;

  ChatDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatmessageCubit()..getallmassage(user!.uId),
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Row(
                children: [
                  CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        "https://www.bitebackpublishing.com/assets/fallback/square_default-6d6494494afb1ec313bd76a6b519e4e6.png",
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'omar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              actions: [
                const SizedBox(
                  width: 10,
                ),
                sendCallButton(isVideoCall: false, uid: user!.uId),
                /* IconButton(
                    onPressed: () {
                      navigateto(
                          context: context,
                          widget: CallEndToEnd(
                            user: user!,
                          ));
                    },
                    icon: const Icon(Icons.call)),*/

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
                              text: tempmassage.text,
                            );
                          }
                          return mymassage(text: tempmassage.text);
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
                                    blocprovider.sendMessage(
                                        receiverId: user!.uId,
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

class mymassage extends StatelessWidget {
  final String text;
  const mymassage({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
          padding: const EdgeInsets.only(top: 25, right: 20.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0))),
            child: Text(text),
          )),
    );
  }
}

class othermassage extends StatelessWidget {
  final String text;
  const othermassage({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 20.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0))),
            child: Text(text),
          )),
    );
  }
}

Widget sendCallButton({
  required bool isVideoCall,
  required String uid,
  void Function(String code, String message, List<String>)? onCallFinished,
}) {
  final invitees = getInvitesFromTextCtrl(uid);

  return ZegoSendCallInvitationButton(
    icon: ButtonIcon(
        icon:
            isVideoCall ? const Icon(Icons.videocam) : const Icon(Icons.phone),
        backgroundColor: Colors.blue),
    isVideoCall: isVideoCall,
    invitees: invitees,
    resourceID: 'zego_data',
    iconSize: const Size(40, 40),
    buttonSize: const Size(50, 50),
    onPressed: onCallFinished,
  );
}

List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {
  final invitees = <ZegoUIKitUser>[];

  final inviteeIDs = textCtrlText.trim().replaceAll('，', '');
  inviteeIDs.split(',').forEach((inviteeUserID) {
    if (inviteeUserID.isEmpty) {
      return;
    }

    invitees.add(ZegoUIKitUser(
      id: inviteeUserID,
      name: 'user_$inviteeUserID',
    ));
  });

  return invitees;
}


/*
ZegoSendCallInvitationButton actionButton(
        bool isVideo, SocialUserModel user, context) =>
    ZegoSendCallInvitationButton(
      text: "",
      icon: ButtonIcon(
          icon: isVideo ? const Icon(Icons.videocam) : const Icon(Icons.phone),
          backgroundColor: Colors.blue),
      clickableBackgroundColor: Colors.transparent,
      iconSize: const Size.square(50.0),
      onPressed: (s1, s2, arrs3) {
        navigateto(
            context: context,
            widget: CallEndToEnd(
              user: user,
            ));
      },
      isVideoCall: isVideo,
      resourceID: "zegouikit_call",
      invitees: [
        ZegoUIKitUser(
          id: user.uId,
          name: user.name ?? 'anayomis',
        ),
      ],
    );
*/