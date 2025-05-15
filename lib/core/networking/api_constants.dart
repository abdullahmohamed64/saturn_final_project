abstract class ApiConstants {
  static const String baseUrl =
      'http://10.0.2.2:80/saturn/';
  static const String signUp = 'auth/signup.php';
  static const String signIn = 'auth/login.php';
  static const String upload = '${baseUrl}upload/';
  static const String getCategorieItems = 'view/home.php';
  static const String addLike = 'add/like.php';
  static const String likedPosts = 'view/post.php';
  static const String addComment = 'add/comment.php';
  static const String favorites = 'view/favorites.php';
  static const String addPost = 'add/post.php';
  static const String userProfile = 'view/user.php';
  static const String getAllUsersUrl = 'chat/info_user.php?'; 
  static const String editUser = 'edit/info_user.php'; 
}
