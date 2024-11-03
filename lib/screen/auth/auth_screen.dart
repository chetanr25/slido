// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   SharedPreferences? prefs;
//   bool authing = false;

//   Future<dynamic> signInWithGoogle() async {
//     setState(() {
//       authing = true;
//     });
//     // print(GoogleSignIn(
//     //         clientId:
//     //             '744128422498-66vrk6ugbf3h3qtukvq5vo4mqtbtgg3f.apps.googleusercontent.com')
//     //     .signInOption);
//     try {
//       String android =
//           '744128422498-66vrk6ugbf3h3qtukvq5vo4mqtbtgg3f.apps.googleusercontent.com';
//       String ios =
//           '744128422498-afe4dgvmcph8kitbj4bqbgg0o5o8l3n5.apps.googleusercontent.com';
//       // String android = '';
//       String web =
//           '744128422498-66vrk6ugbf3h3qtukvq5vo4mqtbtgg3f.apps.googleusercontent.com';
//       final GoogleSignInAccount? googleUser;
//       if (kIsWeb) {
//         googleUser = await GoogleSignIn(clientId: web).signIn();
//       } else if (Platform.isIOS) {
//         googleUser = await GoogleSignIn(clientId: ios).signIn();
//       } else {
//         googleUser = await GoogleSignIn(clientId: android).signIn();
//       }

//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       // navigateWithFadeAnimation(context, const FirstScreen());
//       // Navigator.pop(context);
//       if (Navigator.canPop(context)) Navigator.pop(context);
//       Navigator.of(context).pushReplacement(FadeRoute(
//         page: Builder(
//           builder: (context) {
//             return const FirstScreen();
//             // return const FirstScreen();
//           },
//         ),
//       )

//           // PageRouteBuilder(
//           //   opaque: false,
//           //   pageBuilder: (_, __, ___) => Container(),
//           //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           //     return SlideTransition(
//           //       position: Tween<Offset>(
//           //         begin: const Offset(1.0, 0.0),
//           //         end: Offset.zero,
//           //       ).animate(animation),
//           //       child: const FirstScreen(),
//           //     );
//           //   },
//           //   transitionDuration: const Duration(milliseconds: 500),
//           // ),
//           );

//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } on Exception catch (e) {
//       if (kDebugMode) {
//         print('exception->$e');
//       }
//     }
//     setState(() {
//       authing = false;
//     });

//     // Future.delayed(const Duration(seconds: 1), () {
//     //   Navigator.pop(context);
//     // });
//     // Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
