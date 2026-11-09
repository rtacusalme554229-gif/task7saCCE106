
class Userpost {
  final String id;
  final String userimg;
  final String username;
  final String time;
  final String postcontent;
  final String posting;
  final String numcomments;
  final String numshare;
  bool isLiked;

  Userpost({
    required this.id,
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.posting,
    required this.numcomments,
    required this.numshare,
    required this.isLiked,
  });
}
