import 'package:supabase_flutter/supabase_flutter.dart';

/// Domain entity representing an authenticated user
class AuthUser {
  final String id;
  final String? email;
  final String? phone;
  final String? displayName;
  final String? username;
  final String? avatarUrl;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastSignInAt;
  final String? role;
  final bool isEmailConfirmed;
  final bool isPhoneConfirmed;

  const AuthUser({
    required this.id,
    this.email,
    this.phone,
    this.displayName,
    this.username,
    this.avatarUrl,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.lastSignInAt,
    this.role,
    this.isEmailConfirmed = false,
    this.isPhoneConfirmed = false,
  });

  /// Create AuthUser from Supabase User
  factory AuthUser.fromSupabaseUser(User user) {
    return AuthUser(
      id: user.id,
      email: user.email,
      phone: user.phone,
      displayName:
          user.userMetadata?['display_name'] ?? user.userMetadata?['full_name'],
      username: user.userMetadata?['username'],
      avatarUrl: user.userMetadata?['avatar_url'],
      metadata: user.userMetadata,
      createdAt: user.createdAt != null
          ? DateTime.parse(user.createdAt!)
          : null,
      updatedAt: user.updatedAt != null
          ? DateTime.parse(user.updatedAt!)
          : null,
      lastSignInAt: user.lastSignInAt != null
          ? DateTime.parse(user.lastSignInAt!)
          : null,
      role: user.role,
      isEmailConfirmed: user.emailConfirmedAt != null,
      isPhoneConfirmed: user.phoneConfirmedAt != null,
    );
  }

  /// Create AuthUser from Map
  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      id: map['id'] as String,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      displayName: map['display_name'] as String?,
      username: map['username'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      metadata: map['metadata'] as Map<String, dynamic>?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
      lastSignInAt: map['last_sign_in_at'] != null
          ? DateTime.parse(map['last_sign_in_at'] as String)
          : null,
      role: map['role'] as String?,
      isEmailConfirmed: map['is_email_confirmed'] as bool? ?? false,
      isPhoneConfirmed: map['is_phone_confirmed'] as bool? ?? false,
    );
  }

  /// Convert AuthUser to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'display_name': displayName,
      'username': username,
      'avatar_url': avatarUrl,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'last_sign_in_at': lastSignInAt?.toIso8601String(),
      'role': role,
      'is_email_confirmed': isEmailConfirmed,
      'is_phone_confirmed': isPhoneConfirmed,
    };
  }

  /// Create a copy of AuthUser with updated fields
  AuthUser copyWith({
    String? id,
    String? email,
    String? phone,
    String? displayName,
    String? username,
    String? avatarUrl,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSignInAt,
    String? role,
    bool? isEmailConfirmed,
    bool? isPhoneConfirmed,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      role: role ?? this.role,
      isEmailConfirmed: isEmailConfirmed ?? this.isEmailConfirmed,
      isPhoneConfirmed: isPhoneConfirmed ?? this.isPhoneConfirmed,
    );
  }

  /// Check if user has a specific role
  bool hasRole(String role) {
    return this.role == role;
  }

  /// Check if user has any of the specified roles
  bool hasAnyRole(List<String> roles) {
    return role != null && roles.contains(role);
  }

  /// Get user's display name or fallback to email
  String get displayNameOrEmail {
    return displayName ?? email ?? 'Unknown User';
  }

  /// Get user's initials for avatar
  String get initials {
    if (displayName != null && displayName!.isNotEmpty) {
      final names = displayName!.split(' ');
      if (names.length >= 2) {
        return '${names[0][0]}${names[1][0]}'.toUpperCase();
      }
      return names[0][0].toUpperCase();
    }
    if (email != null && email!.isNotEmpty) {
      return email![0].toUpperCase();
    }
    return 'U';
  }

  /// Check if user is verified (email or phone confirmed)
  bool get isVerified {
    return isEmailConfirmed || isPhoneConfirmed;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthUser && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AuthUser(id: $id, email: $email, displayName: $displayName, isVerified: $isVerified)';
  }
}
