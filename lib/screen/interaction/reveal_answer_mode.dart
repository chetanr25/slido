import 'package:flutter/material.dart';

class RevealAnswerMode extends StatefulWidget {
  const RevealAnswerMode({super.key});

  @override
  State<RevealAnswerMode> createState() => _RevealAnswerModeState();
}

class _RevealAnswerModeState extends State<RevealAnswerMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              leading: const Text(
                '1.',
                style: TextStyle(fontSize: 24),
              ),
              title: const Text(
                'What is the capital of India?',
                style: TextStyle(fontSize: 24),
              ),
              // subtitle: Text(widget.question['answer']),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    color: Colors.blue.withOpacity(0.5),
                    child: ListTile(
                      leading: Text(
                        '${String.fromCharCode(65 + index)}.',
                        style: const TextStyle(fontSize: 20),
                      ),
                      title: const Text(
                        'New Delhi',
                        style: TextStyle(fontSize: 20),
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
