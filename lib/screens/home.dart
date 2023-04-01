import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Text('Home Page'),
          // Text("LOGO"),
          SvgPicture.network(
            'https://www.wingmanweb.com/wp-content/uploads/2022/05/Logo-Main-01-1.svg',
            // 'assets/pv.png',
            width: 200,
            height: 200,
          ),
          Text("NAME"),
          Text("EMAIL"),
        ]),
      ),
    );
  }
}
