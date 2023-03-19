import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/services/phone_auth_service.dart';
import 'otp_verification_page.dart';
import 'main_page.dart';

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
          MaterialPageRoute(builder: (context) => const MainPage()),
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

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
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
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      Fluttertoast.showToast(msg: 'Invalid OTP code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return defaultBackgroundScaffold(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 8,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 64),
                          child: const FractionallySizedBox(
                            widthFactor: 0.5,
                            child:
                                Image(image: AssetImage("assets/app_logo.png")),
                          ),
                        ),
                        const SizedBox(height: 93),
                        const Text(
                          'Phone Number',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 15,
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF201F1F),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 4),
                                    Expanded(
                                        child:
                                            Image.asset("assets/us_flag.png")),
                                    const SizedBox(width: 4),
                                    const Expanded(
                                        child: Text(
                                      "US",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              flex: 85,
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: yellowPrimary,
                                  decoration: InputDecoration(
                                      hintText: '+1 (045) 0000 0025',
                                      focusColor: yellowPrimary,
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: yellowPrimary)),
                                      hintStyle: TextStyle(
                                          color:
                                              Colors.white.withOpacity(0.75)),
                                      filled: true,
                                      fillColor: const Color(0xFF201F1F),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomePage()),
                    // )
                    // _handleSignIn(context)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OTPVerificationPage(
                            phoneNumber: _phoneNumberController.text.trim(),
                          )),
                    )
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: yellowPrimary,
                      padding: const EdgeInsets.all(11.0)),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Flexible(
                  flex: 1,
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFFAAAAAA)),
                            children: [
                              const TextSpan(
                                  text:
                                      "By clicking ‘Get Started’ you adhere to our "),
                              TextSpan(
                                text: "Terms of Service",
                                style: const TextStyle(color: yellowPrimary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => print('Open web view'),
                              ),
                              const TextSpan(text: " & "),
                              TextSpan(
                                text: "Privacy Policy.",
                                style: const TextStyle(color: yellowPrimary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => print('Open web view'),
                              ),
                            ])),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
