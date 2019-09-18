import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User extends Equatable {
  final String displayName;
  final String email;
  final String photoUrl;
  final String uid;
  final String phoneNumber;

  User(this.displayName, this.email, this.photoUrl, this.uid, this.phoneNumber);

  @override
  String toString() {
    return "User {displayName: $displayName, email: $email}";
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        uid.hashCode ^
        phoneNumber.hashCode;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          displayName == other.displayName &&
          email == other.email &&
          photoUrl == other.photoUrl &&
          uid == other.uid &&
          phoneNumber == other.phoneNumber;

  FirebaseUser toEntity(){

  }

  static User fromEntity(FirebaseUser entity) {
    return User(
      entity.displayName,
      entity.email,
      entity.photoUrl,
      entity.uid,
      entity.phoneNumber,
    );
  }
}
