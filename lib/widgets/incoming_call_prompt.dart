import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:mobile_call_app/models/call_state.dart';
import 'package:provider/provider.dart';
import '../utils/state_manager.dart';

class IncomingCallPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final callStateManager = Provider.of<CallStateManager>(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.green,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/video.png'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Incoming Call...',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActionButton(
                  icon: Icons.call,
                  color: Colors.green,
                  onPressed: () {
                    callStateManager.acceptCall();
                    showCustomSnackbar(
                        context, 'Call Accepted!', ContentType.success);
                  },
                ),
                buildActionButton(
                  icon: Icons.call_end,
                  color: Colors.red,
                  onPressed: () {
                    callStateManager.setState(CallState.idle);
                    showCustomSnackbar(
                        context, 'Call Rejected!', ContentType.failure);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(
      {required IconData icon,
      required Color color,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: Icon(icon, size: 32, color: Colors.white),
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
