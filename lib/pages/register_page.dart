import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/services/phone_auth_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../base/utils.dart';
import 'otp_verification_page.dart';
import 'main/main_page.dart';

class RegisterPage extends StatefulWidget {
  final String phoneNumber;

  const RegisterPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updateUserInfo(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() {
      _isLoading = true;
    });
    await _auth.currentUser?.updateDisplayName(_nameController.text);
    if (_emailController.text.trim().isNotEmpty) {
      await _auth.currentUser?.updateEmail(_emailController.text.trim());
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return defaultBackgroundScaffold(
      scaffold: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 36),
                          child: const FractionallySizedBox(
                            widthFactor: 0.5,
                            child:
                                Image(image: AssetImage("assets/app_logo.png")),
                          ),
                        ),
                        const SizedBox(height: 46),
                        Text(
                          // myprofilecqv (0:608)
                          'Full Name',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 6.0),
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: yellowPrimary,
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  color: Colors.white, fontSize: 0),
                              hintText: 'John Appleseed',
                              focusColor: yellowPrimary,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: yellowPrimary)),
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.75)),
                              filled: true,
                              fillColor: const Color(0xFF201F1F),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 26),
                        Text(
                          // myprofilecqv (0:608)
                          'Email',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 6.0),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: yellowPrimary,
                          decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  color: Colors.white, fontSize: 0),
                              hintText: 'xyz.edu@hotmail.com',
                              focusColor: yellowPrimary,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: yellowPrimary)),
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.75)),
                              filled: true,
                              fillColor: const Color(0xFF201F1F),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 26),
                        Text(
                          // myprofilecqv (0:608)
                          'Phone Number',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                          ),
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
                                  enabled: false,
                                  initialValue: widget.phoneNumber,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: yellowPrimary,
                                  decoration: InputDecoration(
                                      errorStyle: const TextStyle(
                                          color: Colors.white, fontSize: 0),
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
                                      return 'Please input your phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 26.0),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () =>
                      {_isLoading ? null : _updateUserInfo(context)},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: yellowPrimary,
                      padding: const EdgeInsets.all(11.0)),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Align(
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
                                ..onTap = () async {
                                  final termOfUseUrl = Uri(
                                      scheme: 'https',
                                      host: 'www.ulimo.co',
                                      path: '/terms-of-use');
                                  if (await canLaunchUrl(termOfUseUrl)) {
                                    await launchUrl(termOfUseUrl);
                                  } else {
                                    throw 'Could not launch $termOfUseUrl';
                                  }
                                },
                            ),
                          ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
