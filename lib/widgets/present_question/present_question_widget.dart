import 'package:flutter/material.dart';

class PresentQuestionWidget extends StatelessWidget {
  const PresentQuestionWidget(
      {super.key, required this.question, required this.currentQuestion});
  final question;
  final currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ListTile(
          leading: Text(
            '${currentQuestion + 1}.',
            style: const TextStyle(fontSize: 28),
          ),
          title: Text(
            question['question'],
            style: const TextStyle(fontSize: 34),
          ),
        ),
        const SizedBox(height: 20),
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
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.5),
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
    );
  }
}
