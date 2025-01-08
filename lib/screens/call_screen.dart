import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/state_manager.dart';
import '../widgets/call_action_buttons.dart';
import '../widgets/incoming_call_prompt.dart';
import '../models/call_state.dart';

class CallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final callStateManager = Provider.of<CallStateManager>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: callStateManager.currentState == CallState.idle
          ? AppBar(
              backgroundColor: Colors.green[700],
              title: const Text('WhatsApp Call Console'),
              centerTitle: true,
            )
          : null,
      body: Stack(
        children: [
          // Background for Video Placeholder
          Positioned.fill(
            child: callStateManager.currentState == CallState.inCall
                ? Image.asset(
                    'assets/images/play_video.png',
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.black,
                  ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (callStateManager.currentState == CallState.idle)
                  buildIdleScreen(context, callStateManager),
                if (callStateManager.currentState == CallState.ringing)
                  IncomingCallPrompt(),
                if (callStateManager.currentState == CallState.inCall)
                  buildInCallScreen(),
                if (callStateManager.currentState == CallState.callEnded)
                  const Text(
                    'Call Ended',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIdleScreen(
      BuildContext context, CallStateManager callStateManager) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/whatsapp.webp'),
        ),
        const SizedBox(height: 20),
        const Text(
          'Welcome to WhatsApp Calls!',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 40),
        buildActionButton(
          context,
          icon: Icons.call,
          label: 'Start Audio Call',
          color: Colors.green,
          onPressed: () {
            callStateManager.setState(CallState.inCall);
            showCustomSnackbar(
                context, 'Audio Call Started!', ContentType.success);
          },
        ),
        const SizedBox(height: 16),
        buildActionButton(
          context,
          icon: Icons.video_call,
          label: 'Start Video Call',
          color: Colors.green,
          onPressed: () {
            callStateManager.setState(CallState.inCall);
            showCustomSnackbar(
                context, 'Video Call Started!', ContentType.success);
          },
        ),
        const SizedBox(height: 16),
        buildActionButton(
          context,
          icon: Icons.ring_volume,
          label: 'Simulate Incoming Call',
          color: Colors.blue,
          onPressed: () {
            callStateManager.simulateIncomingCall();
            showCustomSnackbar(
                context, 'Incoming Call Simulated!', ContentType.warning);
          },
        ),
      ],
    );
  }

  Widget buildInCallScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'In Call...',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20),
        CallActionButtons(isVideoCall: true),
      ],
    );
  }

  Widget buildActionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  void showCustomSnackbar(
      BuildContext context, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Notification',
        message: message,
        contentType: type,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
