import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:slido/consts.dart';

// class ShowSelections extends StatefulWidget {
//   const ShowSelections(
//       {super.key, required this.question, required this.currentQuestion});
//   final question;
//   final currentQuestion;

//   @override
//   State<ShowSelections> createState() => _ShowSelectionsState();
// }

class ShowSelections extends StatelessWidget {
  const ShowSelections(
      {Key? key,
      required this.question,
      required this.correctAnswer,
      required this.response})
      : super(key: key);
  final response;
  final int correctAnswer;
  final question;

  @override
  Widget build(BuildContext context) {
    // print('hehe ${response['optionSelected']['0'].length}');
    print(response['optionSelected']['0'].length ??
        0 / (response['correctNo'] + response['wrongNo']));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Text(
                '1.',
                style: TextStyle(fontSize: 24),
              ),
              title: Text(
                question['question'],
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
                var totalResponse = response['correctNo'] + response['wrongNo'];
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 7, right: 2),
                  child: ListTile(
                    leading: Text(
                      '${String.fromCharCode(65 + index)}.',
                      style: const TextStyle(fontSize: 26),
                    ),
                    title: Text(
                      question['options'][index],
                      style: const TextStyle(fontSize: 26),
                    ),
                    subtitle: LinearProgressIndicator(
                      color: correctAnswer == index ? Colors.green : Colors.red,
                      backgroundColor: Colors.white,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(20),
                      value: totalResponse != 0
                          ? (response['optionSelected'][index.toString()]
                                      .length /
                                  (totalResponse)) ??
                              1
                          : 0,
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
