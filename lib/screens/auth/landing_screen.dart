import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multifocus/utils/colors.dart';
import 'package:multifocus/utils/routes.dart';
import 'package:multifocus/widgets/button_widget.dart';
import 'package:multifocus/widgets/dialogs/about_us_dialog.dart';
import 'package:multifocus/widgets/text_widget.dart';
import 'package:multifocus/widgets/textfield_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  Future<void> performLogin(BuildContext context) async {
    try {
      final scopes = ['email', 'profile']; // Scopes for Microsoft login
      final parameters = {
        'tenant': 'f8cdef31-a31e-4b4a-93e4-5f571e91255a'
      }; // Add your tenant ID
      await FirebaseAuthOAuth()
          .openSignInFlow('microsoft.com', scopes, parameters);
    } on PlatformException catch (error) {
      debugPrint("${error.code}: ${error.message}");
    }
    Navigator.of(context).pushReplacementNamed(Routes().homescreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/2.jpg'),
            fit: BoxFit.cover,
            opacity: 100,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    signinPopupDialog(context);
                  },
                  child: TextRegular(
                    text: 'SIGN IN/UP',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const AboutusDialog(),
                          );
                        });
                  },
                  child: TextRegular(
                    text: 'ABOUT US',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextBold(
                  text: 'The worst enemy to',
                  fontSize: 68,
                  color: Colors.white,
                ),
                TextBold(
                  text: 'creativity is self-doubt.',
                  fontSize: 68,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 50,
                ),
                ButtonWidget(
                  width: 250,
                  fontSize: 18,
                  textColor: primaryGrey,
                  radius: 100,
                  color: Colors.white,
                  label: 'ENTER WORKSPACE',
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes().homescreen);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  signinPopupDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: 325,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: primaryGrey,
                          )),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/MultiFocus Logomark@4x.png',
                          height: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Are you ready to',
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryGrey,
                            fontFamily: 'QBold',
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        ' be productive?',
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryGrey,
                            fontFamily: 'QBold',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldWidget(
                    radius: 100,
                    filled: true,
                    width: 250,
                    label: 'Outlook Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    isObscure: true,
                    radius: 100,
                    filled: true,
                    width: 250,
                    label: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    minWidth: 250,
                    height: 50,
                    color: primary,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes().homescreen);
                    },
                    child: TextRegular(
                      text: 'Login',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    minWidth: 250,
                    height: 50,
                    color: Colors.white,
                    onPressed: () async {
                      performLogin(context);
                    },
                    child: SizedBox(
                      width: 225,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'assets/images/micro.png',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                          TextRegular(
                            text: 'Continue with Microsoft',
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      signupPopupDialog(context);
                    },
                    child: TextBold(
                      text: 'Register New Account',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  signupPopupDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: 325,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: primaryGrey,
                          )),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/MultiFocus Logomark@4x.png',
                          height: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'REGISTER NEW',
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryGrey,
                            fontFamily: 'QBold',
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        'ACCOUNT',
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryGrey,
                            fontFamily: 'QBold',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldWidget(
                    radius: 100,
                    filled: true,
                    width: 250,
                    label: 'Outlook Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    radius: 100,
                    filled: true,
                    width: 250,
                    label: 'Username',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    isObscure: true,
                    radius: 100,
                    filled: true,
                    width: 250,
                    label: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    minWidth: 250,
                    height: 50,
                    color: primary,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes().homescreen);
                    },
                    child: TextRegular(
                      text: 'Signup',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: double.infinity,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          signinPopupDialog(context);
                        },
                        child: TextRegular(
                            text: 'Login', fontSize: 14, color: Colors.white),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
