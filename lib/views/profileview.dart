
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userdata.dart';
import '../model/userpost.dart';
import '../model/usercomment.dart';

class ProfileView extends StatefulWidget {
  final Userpost userPost;
  final Userdata userdata;

  const ProfileView({
    super.key,
    required this.userPost,
    required this.userdata,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController commentController =
      TextEditingController();

  List<Usercomment> comments = [];
  bool loading = true;

  String get storageKey =>
      'comments_${widget.userPost.id}';

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  Future<void> loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(storageKey);

    List<Usercomment> loaded;

    if (saved == null) {
      loaded = widget.userPost.id == 'post1'
          ? List<Usercomment>.from(widget.userdata.commentList)
          : <Usercomment>[];
    } else {
      loaded = saved.map((item) {
        return Usercomment.fromJson(
          jsonDecode(item) as Map<String, dynamic>,
        );
      }).toList();
    }

    if (!mounted) return;

    setState(() {
      comments = loaded;
      loading = false;
    });
  }

  Future<void> addComment() async {
    final message = commentController.text.trim();

    if (message.isEmpty || loading) return;

    final newComment = Usercomment(
      commenterImg: widget.userdata.myUserAccount.img,
      commenterName: widget.userdata.myUserAccount.name,
      commentTime: 'Just now',
      commentContent: message,
    );

    final updated = [...comments, newComment];

    final prefs = await SharedPreferences.getInstance();

    final encoded = updated.map((comment) {
      return jsonEncode(comment.toJson());
    }).toList();

    final saved = await prefs.setStringList(
      storageKey,
      encoded,
    );

    if (!mounted) return;

    if (saved) {
      setState(() {
        comments = updated;
      });
      commentController.clear();
      FocusScope.of(context).unfocus();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save comment. Try again.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Widget commentWidget(Usercomment comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade200,
            child: ClipOval(
              child: Image.asset(
                comment.commenterImg,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0ECF2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.commenterName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment.commentContent,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${comment.commentTime}    Like    Reply',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.userPost;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAE2EE),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: Image.asset(
                        post.userimg,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.person),
                      ),
                    ),
                  ),
                  title: Text(post.username),
                  subtitle: Text(post.time),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(post.postcontent),
                ),
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Image.asset(
                    post.posting,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image, size: 80),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${comments.length} Comments',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${post.numshare} Shares',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          post.isLiked = !post.isLiked;
                        });
                      },
                      icon: Icon(
                        Icons.thumb_up,
                        size: 18,
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
                      onPressed: () {
                        FocusScope.of(context).requestFocus(
                          FocusNode(),
                        );
                      },
                      icon: const Icon(
                        Icons.comment,
                        size: 18,
                        color: Colors.grey,
                      ),
                      label: const Text('Comment'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        size: 18,
                        color: Colors.grey,
                      ),
                      label: const Text('Share'),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '${comments.length} Comments',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'All Comments ▼',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                if (loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  ...comments.map(commentWidget),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8FF),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => addComment(),
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: loading ? null : addComment,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
