// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slido/Providers/shared_preferences_provider.dart';
import 'package:slido/screen/home_screen.dart';
import 'package:slido/util/snack_bar.dart';

class Auth extends ConsumerWidget {
  Auth({Key? key});
  dynamic info() async {
    var info;
    if (Platform.isAndroid) {
      info = await DeviceInfoPlugin().androidInfo;
    } else if (Platform.isIOS) {
      info = await DeviceInfoPlugin().iosInfo;
    } else {
      info = await DeviceInfoPlugin().webBrowserInfo;
      info.browserName = info.browserName.toString();
    }
    return info.data;
  }

  final controller = TextEditingController();

  void createFireContainer(context, ref) async {
    if (controller.text.contains('@') &&
        controller.text.contains('.') &&
        controller.text.length > 5) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', controller.text);
      ref.read(emailProvider.notifier).state = controller.text;
      final email = controller.text;
      final users_collections = FirebaseFirestore.instance.collection('users');
      List all_users =
          await users_collections.doc('all_users').get().then((value) {
        return value.data()!['all_mails'];
      });

      Map<String, dynamic> device = await info();
      if (all_users.contains(email)) {
        prefs.setString('email', email);
        await users_collections.doc(email).update({
          'device': FieldValue.arrayUnion([device]),
        });
        users_collections.doc('all_mails').update({
          'all_mails': FieldValue.arrayUnion([email]),
        });
      } else {
        await users_collections.doc(email).set({
          'device': [device],
          'noOfQuestions': 0,
          'questions': []
        });
      }
      users_collections.doc('all_users').update({
        'all_mails': FieldValue.arrayUnion([email]),
      });
      snack('Successfully Signed in', context: context, color: Colors.green);
      // prefs.setString('email', email);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ));
    } else {
      snack('Invalid email!', context: context, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(label: Text('E-mail')),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  createFireContainer(context, ref);
                },
                child: const Text('Sign in')),
          ],
        ),
      ),
    );
  }
}
