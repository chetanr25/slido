import 'package:flutter/material.dart';

class QuestionMode1 extends StatefulWidget {
  const QuestionMode1(
      {super.key, required this.question, required this.currentQuestion});
  final question;
  final currentQuestion;
  @override
  State<QuestionMode1> createState() => _QuestionModeState();
}

class _QuestionModeState extends State<QuestionMode1> {
  int selectedOption = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Text(
                '${widget.currentQuestion + 1}.',
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                widget.question['question'],
                style: const TextStyle(fontSize: 24),
              ),
              // subtitle: Text(widget.question['answer']),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.question['options'].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: selectedOption == index
                              ? Colors.green
                              : Theme.of(context).colorScheme.primaryContainer,
                          width: 2,
                        ),
                      ),
                      color: selectedOption == index
                          ? Colors.green.withOpacity(0.5)
                          : Theme.of(context).colorScheme.primaryContainer,
                      child: ListTile(
                        leading: Text(
                          '${String.fromCharCode(65 + index)}.',
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          widget.question['options'][index],
                          style: const TextStyle(fontSize: 20),
                        ),
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
