class Comment {
  final int? id;
  final int? postId;
  final int? userId;
  final String? comment;
  final String? createdAt;
  final String? username;
  final String? userPic;

  Comment({
    this.id,
    this.postId,
    this.userId,
    this.comment,
    this.createdAt,
    this.username,
    this.userPic,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      username: json['username'] ?? '',
      userPic: json['pic_name'] ?? '',
    );
  }
}
