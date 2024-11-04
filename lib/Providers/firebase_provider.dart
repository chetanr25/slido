import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slido/Providers/shared_preferences_provider.dart';

final firebaseProvider = Provider((ref) => FirebaseFirestore.instance);

final firebaseInteractionProvider = Provider((ref) {
  final code = ref.watch(emailProvider);
  print('ref.read(codeProvider) ${code} ${ref.watch(codeProvider)}');
  return FirebaseFirestore.instance
      .collection('main')
      .doc(ref.read(codeProvider));
});

final firebaseUsersProvider = Provider((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(ref.read(emailProvider));
});

final firebaseInteractionDataSnapshot = StreamProvider.autoDispose((ref) {
  return ref.watch(firebaseInteractionProvider).snapshots();
});

final firebaseInteractiveData = Provider.autoDispose((ref) {
  final data = ref.watch(firebaseInteractionDataSnapshot);
  return data.when(
    data: (value) => value.data(),
    loading: () => null,
    error: (error, stack) => null,
  );
});
