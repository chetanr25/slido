// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:slido/screen/auth/auth.dart';
// import 'package:slido/screen/home_screen.dart';

// class FirstScreen extends StatefulWidget {
//   const FirstScreen({super.key});

//   @override
//   State<FirstScreen> createState() => _FirstScreenState();
// }

// class _FirstScreenState extends State<FirstScreen> {
//   SharedPreferences? prefs;

//   void prefsInit() async {
//     prefs = await SharedPreferences.getInstance();
//     setState(() {
//       prefs = prefs;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     prefsInit();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (prefs?.getString('email') == null) {
//       return const Auth();
//     }
//     return HomeScreen();

//     Scaffold(
//       appBar: AppBar(
//         title: const Text('First Screen'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               prefs?.remove('email');
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Auth(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text('This is the first screen'),
//       ),
//     );
//   }
// }
