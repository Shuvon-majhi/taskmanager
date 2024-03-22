import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/presentation/screens/set_password_screen.dart';
import 'package:taskmanager/presentation/screens/sign_in_screen.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundwidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text('Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'A 6 digits verification code will be sent to your enmail address',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    controller: _pinTEController,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: AppColors.themecolor,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    appContext: context,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 43,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text("Verify"),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
