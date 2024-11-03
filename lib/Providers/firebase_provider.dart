import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slido/Providers/shared_preferences_provider.dart';

final firebaseProvider = Provider((ref) => FirebaseFirestore.instance);

final firebaseInteractionProvider = Provider((ref) =>
    FirebaseFirestore.instance.collection('main').doc(ref.read(codeProvider)));

final firebaseInteractionDataSnapshot = StreamProvider.autoDispose((ref) {
  return ref.watch(firebaseInteractionProvider).snapshots();
});
