import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail {
  const SignInWithEmail(this.repository);

  final AuthRepository repository;

  Future<AppUser> call({
    required String email,
    required String password,
  }) {
    return repository.signInWithEmail(email: email, password: password);
  }
}
