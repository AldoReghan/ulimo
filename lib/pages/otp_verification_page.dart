import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/services/phone_auth_service.dart';
import 'package:ulimo/widget/otp_number_field.dart';
import '../base/utils.dart';
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
  final TextEditingController _digitOneController = TextEditingController();
  final TextEditingController _digitTwoController = TextEditingController();
  final TextEditingController _digitThreeController = TextEditingController();
  final TextEditingController _digitFourController = TextEditingController();
  final TextEditingController _digitFiveController = TextEditingController();
  final TextEditingController _digitSixController = TextEditingController();

  final FocusNode _digitOneFocusNode = FocusNode();
  final FocusNode _digitTwoFocusNode = FocusNode();
  final FocusNode _digitThreeFocusNode = FocusNode();
  final FocusNode _digitFourFocusNode = FocusNode();
  final FocusNode _digitFiveFocusNode = FocusNode();
  final FocusNode _digitSixFocusNode = FocusNode();
  late String _verificationId;

  @override
  void dispose() {
    // TODO: implement dispose
    _digitOneController.dispose();
    _digitTwoController.dispose();
    _digitThreeController.dispose();
    _digitFourController.dispose();
    _digitFiveController.dispose();
    _digitSixController.dispose();
    _digitOneFocusNode.dispose();
    _digitTwoFocusNode.dispose();
    _digitThreeFocusNode.dispose();
    _digitFourFocusNode.dispose();
    _digitFiveFocusNode.dispose();
    _digitSixFocusNode.dispose();
    super.dispose();
  }

  void _submitOtp() {
    final String digitOne = _digitOneController.text;
    final String digitTwo = _digitTwoController.text;
    final String digitThree = _digitThreeController.text;
    final String digitFour = _digitFourController.text;
    final String digitFive = _digitFiveController.text;
    final String digitSix = _digitSixController.text;

    final String otpCode = '$digitOne$digitTwo$digitThree$digitFour';
    // Use the OTP code as needed (e.g. for authentication)

    // Clear the text fields
    _digitOneController.clear();
    _digitTwoController.clear();
    _digitThreeController.clear();
    _digitFourController.clear();
    _digitFiveController.clear();
    _digitSixController.clear();
  }

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
  void initState() {
    // Retrieve verification ID from PhoneAuthService
    // _phoneAuthService.signInWithPhoneNumber('', (credential) {
    //   _verificationId = credential.verificationId ?? '';
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   _handleSignIn(context);
    // });

    // _handleSignIn(context);

    super.initState();

    // _handleSignIn(context);
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
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              const Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(
                height: 36,
              ),
              Container(
                // group9ybW (0:135)
                margin:
                    EdgeInsets.fromLTRB(0.11 * fem, 0 * fem, 0 * fem, 46 * fem),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // verifytyN (0:136)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 2 * fem),
                      child: Text(
                        'Verify',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 24 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 315 * fem,
                      ),
                      child: Text(
                        'Please verify your phone number by entering the OTP send to you',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xbfaaaaaa),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 46),
              SizedBox(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    otpNumberField(
                        context, _digitOneController, _digitOneFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitTwoFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(
                        context, _digitTwoController, _digitTwoFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitThreeFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(
                        context, _digitThreeController, _digitThreeFocusNode,
                        () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitFourFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(
                        context, _digitFourController, _digitFourFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitFiveFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(
                        context, _digitFiveController, _digitFiveFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitSixFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(
                        context, _digitSixController, _digitSixFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).unfocus();
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                // didyougetanycodeifnotclickrese (0:142)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 35 * fem),
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 305 * fem,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: SafeGoogleFont(
                      'Barlow',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w300,
                      height: 1.2000000477 * ffem / fem,
                      color: const Color(0xffaaaaaa),
                    ),
                    children: [
                      TextSpan(
                        text: 'Did you get any code? If not, click',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xffaaaaaa),
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w300,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xffaaaaaa),
                        ),
                      ),
                      TextSpan(
                        text: 'Resend',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xfffdcb5b),
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xffaaaaaa),
                        ),
                      ),
                      TextSpan(
                        text: 'after 1 minute',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xffaaaaaa),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: yellowPrimary),
                child: Container(
                  // buttonB4c (0:161)
                  width: double.infinity,
                  height: 50 * fem,
                  decoration: BoxDecoration(
                    color: const Color(0xfffdcb5b),
                    borderRadius: BorderRadius.circular(5 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: SafeGoogleFont(
                        'Saira',
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.575 * ffem / fem,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('OTP Verification'),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Form(
    //       key: _formKey,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text(
    //             'Please enter the OTP code sent to your phone number',
    //             textAlign: TextAlign.center,
    //           ),
    //           const SizedBox(height: 32.0),
    //           TextFormField(
    //             controller: _otpController,
    //             keyboardType: TextInputType.number,
    //             decoration: const InputDecoration(
    //               hintText: 'Enter OTP code',
    //               border: OutlineInputBorder(),
    //             ),
    //             validator: (value) {
    //               if (value == null || value.isEmpty) {
    //                 return 'Please enter OTP code';
    //               }
    //               return null;
    //             },
    //           ),
    //           const SizedBox(height: 32.0),
    //           ElevatedButton(
    //             onPressed: () => _handleSignIn(context),
    //             child: const Text('Verify OTP'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
