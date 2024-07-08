// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc('first')
              .snapshots(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.error is FirebaseException) {
              FirebaseException error = snapshot.error as FirebaseException;
              // Handle FirebaseException specifically
              return Text('Firebase Error: ${error.message}');
            }
            if (snapshot.hasError) {
              if (snapshot.error is FirebaseException) {
                FirebaseException error = snapshot.error as FirebaseException;
                // Handle FirebaseException specifically
                return Text('Firebase Error: ${error.message}');
              }
              // return const Text('Error');
            }
            var userDocument = snapshot.data;
            print(userDocument);
            print(userDocument!['no']);
            // return Text('hehe');
            if (userDocument!['no'] == '1') {
              return const Text('No data');
            } else if (userDocument['no'] == '2') {
              return const Text('Somethings there');
            }
            return Text('Error');
          },
        ),
      ),
    );
  }
}
