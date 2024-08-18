abstract class IAuthLocalDataSource {
  Future<void> login({required String email});
  Future<String> getSession();
  Future<void> logout();
}
