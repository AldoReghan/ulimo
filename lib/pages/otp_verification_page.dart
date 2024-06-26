import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

// import 'package:sms_autofill/sms_autofill.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/pages/register_page.dart';
import 'package:ulimo/services/phone_auth_service.dart';
import 'package:ulimo/widget/otp_number_field.dart';
import '../base/utils.dart';
import 'main/main_page.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage(
      {super.key, required this.phoneNumber, required this.verificationId});

  final String phoneNumber;
  final String verificationId;

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> with CodeAutoFill {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _phoneAuthService = PhoneAuthService();
  final TextEditingController _digitOneController = TextEditingController();
  final TextEditingController _digitTwoController = TextEditingController();
  final TextEditingController _digitThreeController = TextEditingController();
  final TextEditingController _digitFourController = TextEditingController();
  final TextEditingController _digitFiveController = TextEditingController();
  final TextEditingController _digitSixController = TextEditingController();

  final  _pinFieldController = TextEditingController();

  final FocusNode _digitOneFocusNode = FocusNode();
  final FocusNode _digitTwoFocusNode = FocusNode();
  final FocusNode _digitThreeFocusNode = FocusNode();
  final FocusNode _digitFourFocusNode = FocusNode();
  final FocusNode _digitFiveFocusNode = FocusNode();
  final FocusNode _digitSixFocusNode = FocusNode();
  late String _verificationId;
  String codeOtpForAutoFill = '';
  Color otpStatusColor = yellowPrimary;
  bool _isLoading = false;

  String otpCode = '';


  @override
  void codeUpdated() {
    setState(() {
      otpCode = code??'';
    });

    if(code?.length == 6){
      if (kDebugMode) {
        print(code);
      }

      _digitOneController.text = code?[0]??'';
      _digitTwoController.text = code?[1]??'';
      _digitThreeController.text = code?[2]??'';
      _digitFourController.text = code?[3]??'';
      _digitFiveController.text = code?[4]??'';
      _digitSixController.text = code?[5]??'';

    }
  }

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
    // SmsAutoFill().unregisterListener();
    cancel();
    unregisterListener();
    super.dispose();
  }

  void _submitOtp() {
    setState(() {
      otpStatusColor = yellowPrimary;
    });
    final String digitOne = _digitOneController.text;
    final String digitTwo = _digitTwoController.text;
    final String digitThree = _digitThreeController.text;
    final String digitFour = _digitFourController.text;
    final String digitFive = _digitFiveController.text;
    final String digitSix = _digitSixController.text;

    final String otpCode =
        '$digitOne$digitTwo$digitThree$digitFour$digitFive$digitSix';
    // Use the OTP code as needed (e.g. for authentication)

    _handleOTPVerification(context, widget.verificationId, otpCode);

    // Clear the text fields
    // _digitOneController.clear();
    // _digitTwoController.clear();
    // _digitThreeController.clear();
    // _digitFourController.clear();
    // _digitFiveController.clear();
    // _digitSixController.clear();
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



    listenForCode();

    getAppsignature();

    super.initState();

    // _handleSignIn(context);
  }

  Future<void> getAppsignature() async {
    final appSignature = await SmsAutoFill().getAppSignature;
    print("app signatureee $appSignature");
  }

  Future<void> _handleOTPVerification(
      BuildContext context, String verificationId, String otpCode) async {
    // final isValid = _formKey.currentState?.validate() ?? false;
    // if (!isValid) return;

    setState(() {
      _isLoading = true;
    });

    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    final userCredential = await _phoneAuthService
        .signInWithCredential(credential)
        .catchError((error) {
      print(error);
    });

    if (userCredential != null) {
      // Sign in successful
      // ignore: use_build_context_synchronously

      final token = await FirebaseMessaging.instance.getToken();

      final userSnapshot = await FirebaseDatabase.instance
          .ref()
          .child('users')
          .orderByChild('uid')
          .equalTo(userCredential.user?.uid)
          .once();

      final Map<dynamic, dynamic>? userData =
          userSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (userData == null) {
        final databaseRef = FirebaseDatabase.instance.ref('users').push();
        await databaseRef
            .set({'uid': userCredential.user?.uid, 'messageToken': token});
      } else {
        userData.forEach((key, value) async {
          if (value["messageToken"] != token) {
            await FirebaseDatabase.instance
                .ref()
                .child('users')
                .child(key)
                .update({"messageToken": token});
          }
        });
      }

      if (userCredential.user?.displayName == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPage(
                    phoneNumber: widget.phoneNumber,
                  )),
        );
      } else {
        Navigator.of(context).popUntil((route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } else {
      Fluttertoast.showToast(msg: 'Invalid OTP code');
      setState(() {
        otpStatusColor = Colors.red;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _handleSignIn(BuildContext context) async {
    final phoneNumber = widget.phoneNumber;

    void verificationCompleted(PhoneAuthCredential credential) async {
      final userCredential =
          await _phoneAuthService.signInWithCredential(credential);

      if (userCredential != null) {
        // Sign in successful
        // ignore: use_build_context_synchronously
        if (userCredential.user?.displayName == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterPage(
                      phoneNumber: phoneNumber,
                    )),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        }
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
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                )),
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

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Container(
                // group9ybW (0:135)
                margin:
                    EdgeInsets.fromLTRB(0.11 * fem, 0 * fem, 0 * fem, 46 * fem),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
              ),
              const SizedBox(height: 46),
              SizedBox(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    otpNumberField(
                        context,
                        _digitOneController,
                        otpStatusColor,
                        _digitOneFocusNode,
                        () {
                          //do somethiing
                          FocusScope.of(context)
                              .requestFocus(_digitTwoFocusNode);
                        },
                        isFirst: true,
                        onPasteCode: (code) {
                          _digitOneController.text = code[0];
                          _digitTwoController.text = code[1];
                          _digitThreeController.text = code[2];
                          _digitFourController.text = code[3];
                          _digitFiveController.text = code[4];
                          _digitSixController.text = code[5];
                        }),
                    const SizedBox(width: 7),
                    otpNumberField(context, _digitTwoController, otpStatusColor,
                        _digitTwoFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitThreeFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(context, _digitThreeController,
                        otpStatusColor, _digitThreeFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitFourFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(context, _digitFourController,
                        otpStatusColor, _digitFourFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitFiveFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(context, _digitFiveController,
                        otpStatusColor, _digitFiveFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).requestFocus(_digitSixFocusNode);
                    }),
                    const SizedBox(width: 7),
                    otpNumberField(context, _digitSixController, otpStatusColor,
                        _digitSixFocusNode, () {
                      //do somethiing
                      FocusScope.of(context).unfocus();
                    }),
                  ],
                ),
              ),
              SizedBox(height: 55 * fem),
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            _handleSignIn(context);
                            // print("resend");
                          },
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
              _isLoading
                  ? const Center(
                      child: SizedBox(
                        height: 50,
                        child: AspectRatio(
                            aspectRatio: 1, child: CircularProgressIndicator()),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const MainPage()),
                        // );
                        _isLoading ? null : _submitOtp();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: yellowPrimary),
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
  }


}
