import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/screens/auth/sign_in_screen.dart';
import 'package:taskmanager/presentation/widgets/app_logo.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    _moveToSignIn();
  }

  Future<void> _moveToSignIn() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: backgroundwidget(
        child: Center(
          child: applogo(),
        ),
      ),
    );
  }
}
