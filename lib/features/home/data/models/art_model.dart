import 'package:saturn/features/home/data/models/comment_model.dart';

// "data": [
//       {
//           "id": 1,
//           "user_id": 1,
//           "type": "image",
//           "category": "pic",
//           "name_image": "6169isg1.jpg",
//           "description": "00",
//           "created_at": "2025-03-11 14:55:51",
//           "likes_count": 4
//       },
class PostModel {
  final int? id;
  final int? userId;

  final String? status;
  final bool? liked;
  final List<Comment>? comments;

  final int? likesCount;

  final String? type;
  final String? categoryName;
  final String? imageName;
  final String? description;
  final String? createdAt;
  final String? title;

  PostModel({
    this.title,
    this.status,
    this.liked,
    this.comments,
    this.id,
    this.userId,
    this.type,
    this.categoryName,
    this.imageName,
    this.description,
    this.createdAt,
    this.likesCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];
    if (json['comments'] != null) {
      comments =
          (json['comments'] as List).map((e) => Comment.fromJson(e)).toList();
    }
    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      categoryName: json['category'],
      imageName: json['name_image'],
      description: json['description'],
      createdAt: json['created_at'],
      likesCount: json['likes_count'],
      status: json['status'],
      liked: json['liked'],
      comments: comments,
    );
  }
}
