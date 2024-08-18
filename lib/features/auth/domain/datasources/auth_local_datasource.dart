abstract class IAuthLocalDataSource {
  Future<void> login({required String email});
  Future<String> existSession();

  Future<void> logout();
}
