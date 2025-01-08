import 'package:flutter/material.dart';
import 'package:mobile_call_app/screens/call_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobile_call_app/utils/state_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CallStateManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobile Call App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CallScreen(),
      ),
    );
  }
}
