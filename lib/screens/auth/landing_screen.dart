import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multifocus/utils/colors.dart';
import 'package:multifocus/utils/routes.dart';
import 'package:multifocus/widgets/button_widget.dart';
import 'package:multifocus/widgets/dialogs/about_us_dialog.dart';
import 'package:multifocus/widgets/text_widget.dart';
import 'package:multifocus/widgets/textfield_widget.dart';

import '../../widgets/toast_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  // Future<void> performLogin() async {
  //   try {
  //     final provider = OAuthProvider('microsoft.com');
  //     await FirebaseAuthWeb.instance.signInWithPopup(provider);
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       // User is signed in successfully
  //       print('User: ${user.uid}');
  //     } else {
  //       // User is not signed in
  //       print('User is not signed in');
  //     }
  //   } catch (e) {
  //     print('Error signing in with Microsoft: $e');
  //   }
  // }

  // Future<void> performLogin() async {
  //   try {
  //     const redirectUri =
  //         'http://localhost:60190/'; // Replace with your redirect URI
  //     const clientId =
  //         'f8cdef31-a31e-4b4a-93e4-5f571e91255a'; // Replace with your client ID

  //     const authorizationEndpoint =
  //         'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
  //     final queryParams = {
  //       'client_id': clientId,
  //       'response_type': 'code',
  //       'redirect_uri': redirectUri,
  //       'scope': 'openid email profile', // Add additional scopes if needed
  //     };

  //     final authorizationUrl = Uri.parse(authorizationEndpoint)
  //         .replace(queryParameters: queryParams);

  //     // Open the authorization URL in a new window
  //     window.open(authorizationUrl.toString(), 'Microsoft Login');
  //   } catch (e) {
  //     print('Error initiating Microsoft login: $e');
  //   }
  // }

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
                    signinPopupDialog(context);
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
                      login(context);
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
                      Navigator.pushReplacementNamed(
                          context, Routes().homescreen);
                      // performLogin();
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
                      register(context);
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

  login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showToast('Logged in succesfully!');
      Navigator.of(context).pushReplacementNamed(Routes().homescreen);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      final user = FirebaseAuth.instance.currentUser;

      await user?.updateDisplayName(nameController.text);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      showToast('Account created succesfully!');
      Navigator.of(context).pushReplacementNamed(Routes().homescreen);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
