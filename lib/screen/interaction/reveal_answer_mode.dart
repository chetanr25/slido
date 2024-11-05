import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:slido/Providers/firebase_provider.dart';
import 'package:slido/consts.dart';

// class RevealAnswerMode extends StatefulWidget {
//   const RevealAnswerMode({super.key});
//   @override
//   State<RevealAnswerMode> createState() => _RevealAnswerModeState();
// }

class RevealAnswerMode extends ConsumerWidget {
  const RevealAnswerMode(
      {super.key,
      required this.question,
      required this.correctAnswer,
      required this.response});
  final response;
  final int correctAnswer;
  final question;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final firebaseResponse = ref.read(firebaseInteractionProvider).get();
    // print(firebaseResponse['response']);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              leading: Text(
                '1.',
                style: TextStyle(fontSize: 24),
              ),
              title: Text(
                'What is the capital of India?',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: question['options'].length,
              itemBuilder: (context, index) {
                return Card(
                  shape: cardStyle(context),
                  color: index != correctAnswer
                      ? Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5)
                      : Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 2),
                    child: ListTile(
                      leading: Text(
                        '${String.fromCharCode(65 + index)}.',
                        style: const TextStyle(fontSize: 26),
                      ),
                      title: Text(
                        question['options'][index],
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Correct: ${response['correctNo']}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Wrong: ${response['wrongNo']}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                // Card(
                //   child: Text(response['wrongNo'].toString()),
                // )
              ],
            ),
            const Gap(20),
            Text(
              'Correct Answer: ${question['options'][correctAnswer]}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
