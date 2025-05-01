import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/core/route/route_name.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';
import 'package:watch_shop/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticateWithDeviceCredentials();
    });
  }

  Future<void> _authenticateWithDeviceCredentials() async {
    bool authenticated = await authService.authenticateWithDeviceCredentials();
    if (authenticated) {
      // ignore: use_build_context_synchronously
      GoRouter.of(context).pushReplacementNamed(RouteName.home);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('احراز هویت با رمز گوشی ناموفق بود')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'برای ورود اثر انگشت یا رمز گوشی خود را وارد کنید',
              style: AppTextStyle.fingerPrintTextStyle,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "تلاش دوباره",
              onPressed: _authenticateWithDeviceCredentials,
              shape: ButtonShape.rounded,
            ),
          ],
        ),
      ),
    );
  }
}
