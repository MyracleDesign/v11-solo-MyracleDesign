import 'models/models.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();

  Future<String> getUserId();

  Future<User> signInWithGoogle();

  Future<void> signInWithCredentials(String email, String password);

  Future<void> signUp({String email, String password});

  Future<void> signOut();

  Future<User> getCurrentUser();

}
