
import 'package:flutter/material.dart';
import '../model/userdata.dart';

class Mainheader extends StatelessWidget {
  final Userdata userdata;

  const Mainheader({
    super.key,
    required this.userdata,
  });

  @override
  Widget build(BuildContext context) {
    final account = userdata.myUserAccount;

    return Column(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade200,
          child: ClipOval(
            child: Image.asset(
              account.img,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.grey,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          account.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          account.email,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
