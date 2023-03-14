import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulimo/services/phone_auth_service.dart';
import 'otp_verification_page.dart';
import 'home_page.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _phoneAuthService = PhoneAuthService();

  Future<void> _handleSignIn(BuildContext context) async {
    final phoneNumber = _phoneNumberController.text.trim();
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    bool isSignInSuccessful = false;

    void verificationCompleted(PhoneAuthCredential credential) async {
      final userCredential =
          await _phoneAuthService.signInWithCredential(credential);
      if (userCredential != null) {
        // Sign in successful
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        Fluttertoast.showToast(msg: 'Failed to sign in with phone number');
      }
    }

    void verificationFailed(FirebaseAuthException exception) {
      Fluttertoast.showToast(
          msg: 'Failed to verify phone number: ${exception.message}');
    }

    void codeSent(String verificationId, int? forceResendingToken) {
      // Navigate to OTP verification page

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => OTPVerificationPage(
      //             phoneNumber: phoneNumber,
      //           )),
      // );
    }

    void codeAutoRetrievalTimeout(String verificationId) {}

    try {
      await _phoneAuthService.verifyPhoneNumber(
        phoneNumber,
        verificationCompleted,
        verificationFailed,
        codeSent,
        codeAutoRetrievalTimeout,
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to verify phone number');
    }
  }

  Future<void> _handleOTPVerification(
      BuildContext context, String verificationId) async {
    final otpCode = _otpController.text.trim();
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    final userCredential =
        await _phoneAuthService.signInWithCredential(credential);

    if (userCredential != null) {
      // Sign in successful
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Fluttertoast.showToast(msg: 'Invalid OTP code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please enter your phone number to sign in',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () => {
                  _handleSignIn(context)
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => OTPVerificationPage(
                  //         phoneNumber: _phoneNumberController.text.trim(),
                  //       )),
                  // )
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
