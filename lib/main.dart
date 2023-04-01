import 'package:demo/screens/phone.dart';
import 'package:demo/screens/home.dart';
import 'package:flutter/material.dart';

import 'controller/storage_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Future<Widget>
  checkForAuthentication() async {
    try {
      StorageController _storage = new StorageController();
      var token = await _storage.checkForAuth();
      if (token != null) {
        return HomePage();
        // AuthController _auth = new AuthController();
        // var userDATA = await _auth.getUserData(phone);
        // if (userDATA == null) {
        //   return const ();
        // }
        // print("++++++++++++++++++++");
        // print(userDATA);
        // print(phone);
        // print("++++++++++++++++++++");
        // return AppBase(usernewId: phone.toString(), usernewData: userDATA);
      } else {
        return PhoneNumberPage();
      }
    } catch (e) {
      return PhoneNumberPage();
    }
  }

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PhoneNumberPage(),
    );
  }
}
