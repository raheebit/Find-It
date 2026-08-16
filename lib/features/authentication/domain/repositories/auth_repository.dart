import '../entities/user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get authStateChanges;

  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AppUser> signInWithGoogle();

  Future<AppUser> registerWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
