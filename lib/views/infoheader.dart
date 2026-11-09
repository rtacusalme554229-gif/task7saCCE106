
import 'package:flutter/material.dart';
import '../model/userdata.dart';

class Infoheader extends StatelessWidget {
  final Userdata userdata;

  const Infoheader({
    super.key,
    required this.userdata,
  });

  Widget infoColumn(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final account = userdata.myUserAccount;

    return Column(
      children: [
        Row(
          children: [
            infoColumn('Followers', account.numFollowers),
            infoColumn('Following', account.numFollowing),
            infoColumn('Posts', account.numPosts),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(
          color: Colors.grey,
          thickness: 0.8,
        ),
      ],
    );
  }
}
