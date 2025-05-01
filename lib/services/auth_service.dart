import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class AuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // چک کردن اینکه آیا بیومتریک در دسترس هست یا نه
  Future<bool> canAuthenticateWithBiometrics() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      debugPrint('Can check biometrics: $canCheck');
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      debugPrint('Available biometrics: $availableBiometrics');
      return canCheck;
    } catch (e) {
      debugPrint('Error checking biometrics: $e');
      return false;
    }
  }

  // چک کردن اینکه آیا دستگاه قفل صفحه داره یا نه
  Future<bool> isDeviceSecure() async {
    try {
      final isSupported = await _localAuth.isDeviceSupported();
      debugPrint('Is device supported: $isSupported');
      return isSupported;
    } catch (e) {
      debugPrint('Error checking device security: $e');
      return false;
    }
  }

  // احراز هویت با اثر انگشت یا پین/الگو
  Future<bool> authenticateWithBiometrics() async {
    try {
      bool canAuthenticate = await canAuthenticateWithBiometrics();
      debugPrint('Can authenticate with biometrics: $canAuthenticate');
      if (!canAuthenticate) {
        debugPrint('No biometric available');
        return false;
      }

      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'لطفاً اثر انگشت خود را برای ورود اسکن کنید',
        options: const AuthenticationOptions(
          biometricOnly: true, // فقط اثر انگشت
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      debugPrint('Biometric authentication result: $authenticated');
      return authenticated;
    } on PlatformException catch (e) {
      debugPrint('Biometric authentication error: ${e.code}, ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return false;
    }
  }

  // احراز هویت با رمز گوشی (پین/الگو/پسورد)
  Future<bool> authenticateWithDeviceCredentials() async {
    try {
      bool canAuthenticate = await isDeviceSecure();
      debugPrint('Can authenticate with device credentials: $canAuthenticate');
      if (!canAuthenticate) {
        debugPrint('No device credentials available');
        return false;
      }

      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'لطفاً پین، الگو یا رمز گوشی خود را وارد کنید',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      debugPrint('Device credentials authentication result: $authenticated');
      return authenticated;
    } on PlatformException catch (e) {
      debugPrint('Device credentials authentication error: ${e.code}, ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return false;
    }
  }
}