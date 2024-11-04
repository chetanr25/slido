// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slido/Providers/firebase_provider.dart';
import 'package:slido/Providers/shared_preferences_provider.dart';
import 'package:slido/consts.dart';
import 'package:slido/screen/interaction/reveal_answer_mode.dart';
import 'package:slido/screen/interaction/waiting.dart';
import 'package:slido/screen/interaction/present_question.dart';
import 'package:slido/screen/interaction/show_selections.dart';
import 'package:slido/util/snack_bar.dart';

class InteractiveMode extends ConsumerStatefulWidget {
  const InteractiveMode({super.key});

  @override
  ConsumerState<InteractiveMode> createState() => _InteractiveModeState();
}

class _InteractiveModeState extends ConsumerState<InteractiveMode> {
  SharedPreferences? prefs;
  String? email;
  String? code;
  bool isWaiting = true;
  int currentQuestion = 0;
  String mode = 'waiting';
  int noOfQuestions = 0;
  int modeIndex = 0;

  Future<void> createOnFire() async {
    var fireMain = FirebaseFirestore.instance.collection('main');
    var fire = fireMain.doc('active');
    var dataFromFire = await fire.get();
    String randomNumberString = '';
    if (!dataFromFire.data()!.containsKey(email)) {
      snack('Activating slido', context: context, color: Colors.green);
      Random random = Random();
      int randomNumber = random.nextInt(9999);
      randomNumberString = randomNumber.toString().padLeft(5, '0');
      ref.watch(codeNotifierProvider.notifier).setCode(randomNumberString);
      // setState(() {
      //   code = randomNumberString;
      // });
      // CodeNotifier(ref as Ref<Object?>).setCode(code!);
      await fire.set({
        email!: randomNumberString,
      });
      var fireDataForActivating = await ref.read(firebaseUsersProvider).get();
      noOfQuestions = fireDataForActivating.data()!['noOfQuestions'];

      if (!fireDataForActivating.data()!.containsKey('active')) {
        fireDataForActivating.data()!['active'] = randomNumberString;
        await fireMain.doc(randomNumberString).set({
          'email': email,
          'noOfQuestions': fireDataForActivating.data()!['noOfQuestions'],
          'currentQuestion': 0,
          'questions': fireDataForActivating.data()!['questions'],
          'mode': 'waiting',
          'users': [],
          'responses': [
            for (int i = 0; i < noOfQuestions; i++)
              {
                'index': i,
                'optionSelected': [
                  {for (int j = 0; j < 10; j++) '$j': []}
                ],
                'time': [{}],
                'correctNo': 0,
                'correctAnswer': [],
                'wrongAnswer': [],
                'wrongNo': 0,
              }
          ]
        });
      }
    } else {
      code = dataFromFire.data()![email];

      final firebaseInteracionRef =
          FirebaseFirestore.instance.collection('main').doc(code);
      var fireMain = await firebaseInteracionRef.get();
      var data = fireMain.data()!;
      currentQuestion = data['currentQuestion'];
      mode = data['mode'];
      modeIndex = modes.indexOf(mode);
      noOfQuestions = data['noOfQuestions'];
      snack('You are already active\nCode: $code',
          context: context, color: Colors.green, duration: 2);
    }
    setState(() {
      isWaiting = false;
    });

    ref.read(codeNotifierProvider.notifier).setCode(code!);
  }

  void first() async {
    await createOnFire();
  }

  @override
  void initState() {
    super.initState();
    first();
  }

  List<String> modes = ['question', 'answer', 'selections'];
  @override
  Widget build(BuildContext context) {
    email = ref.read(emailProvider);
    code = ref.read(codeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Mode'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () {
                Navigator.pop(context);
                Future.delayed(const Duration(seconds: 2), () {
                  ref.read(firebaseInteractionProvider).delete();

                  FirebaseFirestore.instance
                      .collection('main')
                      .doc('active')
                      .set({
                    email!: FieldValue.delete(),
                  });
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: ElevatedButton.icon(
                iconAlignment: IconAlignment.start,
                onPressed: mode != 'waiting'
                    ? () {
                        modeIndex--;
                        if (modeIndex < 0) {
                          modeIndex = modes.length - 1;
                        }
                        setState(() {
                          mode = modes[modeIndex];
                        });
                        ref
                            .read(firebaseInteractionProvider)
                            .update({'mode': mode});
                      }
                    : null,
                style: buttonStyle(context),
                label: const Text(
                  '',
                  style: TextStyle(fontSize: 16),
                ),
                icon: const Icon(
                  Icons.arrow_left_outlined,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  if (mode == 'waiting') {
                    mode = 'question';
                    ref
                        .read(firebaseInteractionProvider)
                        .update({'mode': mode});

                    return;
                  }
                  modeIndex++;
                  if (modeIndex >= modes.length) {
                    modeIndex = 0;
                  }
                  // setState(() {
                  mode = modes[modeIndex];
                  // });
                  ref.read(firebaseInteractionProvider).update({'mode': mode});
                },
                style: buttonStyle(context),
                label: const Text(
                  '',
                  style: TextStyle(fontSize: 16),
                ),
                icon: const Icon(
                  Icons.arrow_right_alt,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
      body: !isWaiting
          ? StreamBuilder(
              stream: ref.watch(firebaseInteractionProvider).snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print(snapshot.data);
                var currentQuestion = snapshot.data.data()['currentQuestion'];
                if (snapshot.data.data()['mode'] == 'waiting') {
                  return WaitingInteractiveMode(textData: code);
                }
                if (snapshot.data.data()['mode'] == 'question') {
                  Future.delayed(Durations.short1, () {
                    // setState(() {
                    currentQuestion = snapshot.data.data()['currentQuestion'];
                    // });
                  });
                  return PresentQuestionInteractiveMode(
                    question: snapshot.data.data()['questions']
                        [currentQuestion],
                    currentQuestion: currentQuestion,
                    snapshot: snapshot.data.reference,
                  );
                }

                if (snapshot.data.data()['mode'] == 'selections') {
                  return ShowSelections(
                    question: snapshot.data.data()['questions']
                        [currentQuestion],
                    currentQuestion: currentQuestion,
                  );
                }
                if (snapshot.data.data()['mode'] == 'answer') {
                  print(snapshot.data.data()['questions'][currentQuestion]
                      ['correct']);
                  return RevealAnswerMode(
                    question: snapshot.data.data()['questions']
                        [currentQuestion],
                    correctAnswer: snapshot.data.data()['questions']
                        [currentQuestion]['correct'],
                  );
                }

                if (snapshot.data.data()!.containsKey('currentQuestion')) {
                  return Center(
                    child: Text(snapshot.data.data()['questions']
                        [snapshot.data.data()['currentQuestion']]['question']),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return ListTile(
                      title: Text(document['question']),
                      subtitle: Text(document['answer']),
                    );
                  }).toList(),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
