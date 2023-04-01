import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Text('Home Page'),
          Text("LOGO"),
          Text("NAME"),
        ]),
      ),
    );
  }
}
