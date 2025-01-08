import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_call_app/utils/state_manager.dart';
import 'package:mobile_call_app/models/call_state.dart';

class IncomingCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final callStateManager = Provider.of<CallStateManager>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Incoming Call...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    callStateManager.acceptCall();
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Incoming Call',
                        message: 'Call Accepted!',
                        contentType: ContentType.success,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: () {
                    callStateManager.setState(CallState.idle);
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Incoming Call',
                        message: 'Call Rejected!',
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Reject'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
