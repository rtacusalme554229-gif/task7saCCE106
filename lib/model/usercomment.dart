
class Usercomment {
  final String commenterImg;
  final String commenterName;
  final String commentTime;
  final String commentContent;

  Usercomment({
    required this.commenterImg,
    required this.commenterName,
    required this.commentTime,
    required this.commentContent,
  });

  Map<String, dynamic> toJson() => {
    'commenterImg': commenterImg,
    'commenterName': commenterName,
    'commentTime': commentTime,
    'commentContent': commentContent,
  };

  factory Usercomment.fromJson(Map<String, dynamic> json) {
    return Usercomment(
      commenterImg: json['commenterImg'] ?? '',
      commenterName: json['commenterName'] ?? '',
      commentTime: json['commentTime'] ?? '',
      commentContent: json['commentContent'] ?? '',
    );
  }
}
