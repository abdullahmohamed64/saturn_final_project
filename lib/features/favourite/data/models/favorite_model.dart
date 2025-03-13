 class FavoriteModel {

final String? status ;
final bool? liked ;
final List<Comment>? comments ;
final int? likesCount ;

FavoriteModel({required this.status,required this.liked, this.comments,required this.likesCount}); 
  
 factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      status: json['status'],
      liked: json['liked'],
      // comments: List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x))),
      likesCount: json['likes_count'],
    );
 }

}


class Comment{
  final int id ; 
  final int postId ;
  final int userId ; 
  final String comment ; 
  final String createdAt ; 
  final String username ;

  Comment({required this.id,required this.postId,required this.userId,required this.comment,required this.createdAt,required this.username});
 factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      comment: json['comment'],
      createdAt: json['created_at'],
      username: json['username'],
    );
 }
}
/*

"status": "success",
    "liked": true,
    "comments": [
        {
            "id": 5,
            "post_id": 1,
            "user_id": 1,
            "comment": "2th comment",
            "created_at": "2025-03-14 01:00:01",
            "username": "aaabbb4"
        },
        {
            "id": 4,
            "post_id": 1,
            "user_id": 1,
            "comment": "first comment",
            "created_at": "2025-03-14 00:59:38",
            "username": "aaabbb4"
        }
    ]
}





*/

