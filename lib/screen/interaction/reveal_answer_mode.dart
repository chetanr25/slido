import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class RevealAnswerMode extends StatefulWidget {
//   const RevealAnswerMode({super.key});
//   @override
//   State<RevealAnswerMode> createState() => _RevealAnswerModeState();
// }

class RevealAnswerMode extends ConsumerWidget {
  const RevealAnswerMode(
      {super.key, required this.question, required this.correctAnswer});
  final int correctAnswer;
  final question;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 2,
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }
}
