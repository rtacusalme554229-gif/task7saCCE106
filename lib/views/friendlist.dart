
import 'package:flutter/material.dart';
import '../model/userdata.dart';

class Friendlist extends StatelessWidget {
  final Userdata userdata;

  const Friendlist({
    super.key,
    required this.userdata,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            'Friends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(
            '${userdata.friendList.length} Friends',
            style: const TextStyle(fontSize: 11),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          itemCount: userdata.friendList.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final friend = userdata.friendList[index];

            return Card(
              margin: EdgeInsets.zero,
              elevation: 1,
              color: const Color(0xFFF9F3FA),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        friend.img,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.person,
                              size: 45,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(
                        friend.name,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
