import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

/// Custom exception thrown when ApiConstants is used before initialization
class ApiNotInitializedException implements Exception {
  final String message;
  
  const ApiNotInitializedException([
    this.message = 'ApiConstants not initialized. Call ApiConstants.initialize() first.'
  ]);
  
  @override
  String toString() => 'ApiNotInitializedException: $message';
}

class ApiConstants {
  // Cache the base URL to avoid repeated async calls
  static String? _cachedBaseUrl;
  static bool _isInitialized = false;

  /// Private method to determine base URL based on platform and device type
  static Future<String> _determineBaseUrl() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      final isEmulator = !androidInfo.isPhysicalDevice;
      log('Device: Android - ${isEmulator ? "Emulator" : "Real"}');
      return isEmulator
          ? 'http://10.0.2.2/saturn/' // Android Emulator
          : 'http://192.168.1.88/saturn/'; // Real Android
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final isEmulator = !iosInfo.isPhysicalDevice;
      log('Device: iOS - ${isEmulator ? "Simulator" : "Real"}');
      return isEmulator
          ? 'http://localhost/saturn/' // iOS Simulator
          : 'http://192.168.1.88/saturn/'; // Real iOS
    }

    throw Exception('Unsupported platform');
  }

  /// Initialize the base URL (call this once in your app startup)
  static Future<void> initialize() async {
    if (!_isInitialized) {
      _cachedBaseUrl = await _determineBaseUrl();
      _isInitialized = true;
      log('ApiConstants initialized with Base URL: $_cachedBaseUrl');
    }
  }

  /// Returns the cached base URL (throws if not initialized)
  static String get baseUrl {
    if (!_isInitialized || _cachedBaseUrl == null) {
      throw ApiNotInitializedException();
    }
    return _cachedBaseUrl!;
  }

  /// Returns full base URL (async version for convenience)
  static Future<String> getBaseUrl() async {
    if (!_isInitialized) {
      await initialize();
    }
    return baseUrl;
  }

  /// Check if current device is an emulator/simulator
  static Future<bool> isEmulator() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return !androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return !iosInfo.isPhysicalDevice;
    }
    return false;
  }

  /// Get upload URL (synchronous after initialization)
  static String get uploadUrl => '${baseUrl}upload/';

  /// Get upload URL (async version)
  static Future<String> getUploadUrl() async {
    final base = await getBaseUrl();
    return '${base}upload/';
  }

  // API Endpoints (relative paths)
  static const String signUp = 'auth/signup.php';
  static const String signIn = 'auth/login.php';
  static const String getCategorieItems = 'view/home.php';
  static const String addLike = 'add/like.php';
  static const String likedPosts = 'view/post.php';
  static const String addComment = 'add/comment.php';
  static const String favorites = 'view/favorites.php';
  static const String addPost = 'add/post.php';
  static const String userProfile = 'view/user.php';
  static const String getAllUsersUrl = 'chat/info_user.php';
  static const String editUser = 'edit/info_user.php';

  // Helper methods to get full URLs
  static String getFullUrl(String endpoint) => '$baseUrl$endpoint';
  static Future<String> getFullUrlAsync(String endpoint) async {
    final base = await getBaseUrl();
    return '$base$endpoint';
  }
}