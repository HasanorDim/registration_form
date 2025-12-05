import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:registration_form/models/user_model.dart';

class StorageService {
  static const String _userKey = 'registered_user';

  // Save user to shared preferences
  static Future<void> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toMap()); // Convert to JSON string
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      print('Error saving user: $e');
      rethrow;
    }
  }

  // Get user from shared preferences
  static Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return User.fromMap(userMap);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Clear user data
  static Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      print('Error clearing user: $e');
      rethrow;
    }
  }

  // Check if user exists
  static Future<bool> hasUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_userKey);
    } catch (e) {
      print('Error checking user: $e');
      return false;
    }
  }
}
