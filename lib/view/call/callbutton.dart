import 'package:flutter/material.dart';
import 'package:project3/module/user.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallButton extends StatelessWidget {
  const CallButton(
      {super.key, required this.inviteduser, required this.isVideocall});
  final SocialUserModel inviteduser;
  final bool isVideocall;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: ZegoSendCallInvitationButton(
        icon: ButtonIcon(
            icon: !isVideocall
                ? const Icon(Icons.call)
                : const Icon(Icons.video_call),
            backgroundColor: Colors.blue),
        iconSize: const Size(40, 50),
        isVideoCall: isVideocall,
        resourceID: "Answer for me", // For offline call notification
        invitees: [
          ZegoUIKitUser(
            id: inviteduser.uId,
            name: inviteduser.name,
          )
        ],
      ),
    );
  }
}
