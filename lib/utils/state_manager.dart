import 'package:flutter/material.dart';
import 'package:mobile_call_app/models/call_state.dart';

class CallStateManager extends ChangeNotifier {
  CallState _currentState = CallState.idle;

  CallState get currentState => _currentState;

  void setState(CallState state) {
    print('State changing to: $state'); // Debug
    _currentState = state;
    notifyListeners();
  }

  void simulateIncomingCall() {
    print('Simulating incoming call'); // Debug
    setState(CallState.ringing);
  }

  void acceptCall() {
    setState(CallState.inCall);
  }

  void endCall() {
    setState(CallState.callEnded);
    Future.delayed(const Duration(seconds: 2), () {
      setState(CallState.idle);
    });
  }
}
