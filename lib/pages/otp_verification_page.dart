import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulimo/services/phone_auth_service.dart';
import 'home_page.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _phoneAuthService = PhoneAuthService();
  late String _verificationId;

  Future<void> _handleSignIn(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    print("aaaaaaaaaaaaaaaaaaaa");

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

    Future<void> codeSent(
        String verificationId, int? forceResendingToken) async {
      // Navigate to OTP verification page
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => OTPVerificationPage()),
      // );

      _handleOTPVerification(context, verificationId);
    }

    void codeAutoRetrievalTimeout(String verificationId) {}

    try {
      await _phoneAuthService.verifyPhoneNumber(
        widget.phoneNumber,
        verificationCompleted,
        verificationFailed,
        codeSent,
        codeAutoRetrievalTimeout,
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to verify phone number');
    }
  }

  void awaitSignIn() async {
    await _handleSignIn(context);
  }

  @override
  void initState() async {


    // Retrieve verification ID from PhoneAuthService
    // _phoneAuthService.signInWithPhoneNumber('', (credential) {
    //   _verificationId = credential.verificationId ?? '';
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   _handleSignIn(context);
    // });

    // _handleSignIn(context);

    super.initState();

    _handleSignIn(context);



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
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please enter the OTP code sent to your phone number',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter OTP code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () => _handleSignIn(context),
                child: const Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
