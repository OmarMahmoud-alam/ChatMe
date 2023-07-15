import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/Chatmessage/chatmessage_cubit.dart';
import 'package:project3/module/user.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallEndToEnd extends StatelessWidget {
  final SocialUserModel user;

  const CallEndToEnd({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatmessageCubit()..getme(),
        child: BlocConsumer<ChatmessageCubit, ChatmessageState>(
            listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          final blocprovider = BlocProvider.of<ChatmessageCubit>(context);

          return ZegoUIKitPrebuiltCall(
            
              appID: 1046346516,
              appSign:
                  '6073a55b1ebaaddeac45a4823d65231e461d6c1a4d6b0e6d3415d95c121630b7',
              callID: "${user.uId} ${blocprovider.user!.uId}",
              userID: 'user_${blocprovider.user!.uId}',
              userName: blocprovider.user!.name ?? 'Anayomas',
              plugins: [ZegoUIKitSignalingPlugin()],
              config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
        }));
  }
}
