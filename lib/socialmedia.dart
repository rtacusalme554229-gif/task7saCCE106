
import 'package:flutter/material.dart';
import 'model/userdata.dart';
import 'views/mainheader.dart';
import 'views/infoheader.dart';
import 'views/friendlist.dart';
import 'views/postlist.dart';

class Socialmedia extends StatelessWidget {
  Socialmedia({super.key});

  final Userdata userdata = Userdata();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAE2EE),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Mainheader(userdata: userdata),
          Infoheader(userdata: userdata),
          Friendlist(userdata: userdata),
          Postlist(userdata: userdata),
        ],
      ),
    );
  }
}
