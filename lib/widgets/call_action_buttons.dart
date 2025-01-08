import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../utils/state_manager.dart';

class CallActionButtons extends StatelessWidget {
  final bool isVideoCall;

  const CallActionButtons({Key? key, this.isVideoCall = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final callStateManager = Provider.of<CallStateManager>(context, listen: false);

    void showCustomSnackbar(String message, ContentType type) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Action',
          message: message,
          contentType: type,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.mic),
          color: Colors.blue,
          iconSize: 50,
          tooltip: 'Mute/Unmute',
          onPressed: () {
            showCustomSnackbar('Mute/Unmute toggled!', ContentType.success);
          },
        ),
        const SizedBox(width: 30),
        IconButton(
          icon: const Icon(Icons.call_end),
          color: Colors.red,
          iconSize: 50,
          tooltip: 'End Call',
          onPressed: () {
            showCustomSnackbar('Call Ended!', ContentType.failure);
            callStateManager.endCall();
          },
        ),
        const SizedBox(width: 30),
        if (isVideoCall)
          IconButton(
            icon: const Icon(Icons.switch_camera),
            color: Colors.green,
            iconSize: 50,
            tooltip: 'Switch Camera',
            onPressed: () {
              showCustomSnackbar('Camera switched!', ContentType.warning);
            },
          ),
      ],
    );
  }
}
