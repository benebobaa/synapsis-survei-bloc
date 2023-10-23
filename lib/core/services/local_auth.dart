// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthFingerprint {
  final LocalAuthentication _auth;
  LocalAuthFingerprint(this._auth);

  static Future<bool> _canAuthenticate() async =>
      await LocalAuthentication().canCheckBiometrics ||
      await LocalAuthentication().isDeviceSupported();

  Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      return await _auth.authenticate(
          authMessages: [
            const AndroidAuthMessages(
              signInTitle: 'Sign In',
              cancelButton: 'Cancel',
            ),
            const IOSAuthMessages(
              cancelButton: 'Cancel',
            ),
          ],
          localizedReason: 'Please authenticate to login to the app',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ));
    } catch (e) {
      return false;
    }
  }
}
