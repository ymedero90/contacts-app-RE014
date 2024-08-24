import 'package:bcrypt/bcrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SecurityService {
  final String _keyString;
  final String _ivString;

  SecurityService(this._keyString, this._ivString)
      : assert(_keyString.length == 32, 'Key must be 32 characters long'),
        assert(_ivString.length == 16, 'IV must be 16 characters long');

  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }

  String encryptPassword(String password) {
    final key = encrypt.Key.fromUtf8(_keyString);
    final iv = encrypt.IV.fromUtf8(_ivString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  String decryptPassword(String encryptedPassword) {
    final key = encrypt.Key.fromUtf8(_keyString);
    final iv = encrypt.IV.fromUtf8(_ivString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
    return decrypted;
  }
}
