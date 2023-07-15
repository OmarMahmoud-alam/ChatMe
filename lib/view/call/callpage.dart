import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/Chatmessage/chatmessage_cubit.dart';
import 'package:project3/module/user.dart';
import 'package:project3/styles/styles.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallEndToEnd extends StatelessWidget {
  final SocialUserModel user;

  const CallEndToEnd({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatmessageCubit(),
        child: BlocConsumer<ChatmessageCubit, ChatmessageState>(
            listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          return ZegoUIKitPrebuiltCall(
              appID: Comman.appid,
              appSign: Comman.appSign,
              callID: ,
              userID: 'user_${user.uId}',
              userName: user.name ?? 'Anayomas',
              plugins: [ZegoUIKitSignalingPlugin()],
              config: ZegoUIKitPrebuiltCallConfig.groupVideoCall());
        }));
  }
}
