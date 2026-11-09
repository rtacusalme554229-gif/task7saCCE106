
import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import 'profileview.dart';

class Postlist extends StatefulWidget {
  final Userdata userdata;

  const Postlist({
    super.key,
    required this.userdata,
  });

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  void openPost(Userpost post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileView(
          userPost: post,
          userdata: widget.userdata,
        ),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  Widget postCard(Userpost post) {
    return Card(
      color: const Color(0xFFFFF8FF),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(post.userimg),
              onBackgroundImageError: (_, __) {},
            ),
            title: Text(
              post.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              '${post.time}  •  👥',
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Text(post.postcontent),
          ),
          InkWell(
            onTap: () => openPost(post),
            child: SizedBox(
              width: double.infinity,
              height: 260,
              child: Image.asset(
                post.posting,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${post.numcomments} Comments',
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(width: 12),
                Text(
                  '${post.numshare} Shares',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    post.isLiked = !post.isLiked;
                  });
                },
                icon: Icon(
                  Icons.thumb_up,
                  size: 17,
                  color: post.isLiked
                      ? Colors.blue
                      : Colors.grey,
                ),
                label: Text(
                  'Like',
                  style: TextStyle(
                    color: post.isLiked
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () => openPost(post),
                icon: const Icon(
                  Icons.comment,
                  size: 17,
                  color: Colors.grey,
                ),
                label: const Text(
                  'Comment',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 17,
                  color: Colors.grey,
                ),
                label: const Text(
                  'Share',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Posts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        ...widget.userdata.userList.map(postCard),
      ],
    );
  }
}
