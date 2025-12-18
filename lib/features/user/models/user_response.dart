import 'package:learn_getx/features/auth/models/user.dart';

class UserResponse {
  final User user;
  final bool success;

  UserResponse({
    required this.user,
    required this.success
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: User.fromJson(json['user'] ?? {}),
      success: json['success'] ?? false
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user, 'success': success};
  }
}
