import 'package:flutter/material.dart';

class ShowSelections extends StatefulWidget {
  const ShowSelections(
      {super.key, required this.question, required this.currentQuestion});
  final question;
  final currentQuestion;

  @override
  State<ShowSelections> createState() => _ShowSelectionsState();
}

class _ShowSelectionsState extends State<ShowSelections> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Under maintance bro", style: TextStyle(fontSize: 30)),
      ),
    );
    //   return Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           ListTile(
    //             leading: const Text(
    //               '1.',
    //               style: TextStyle(fontSize: 24),
    //             ),
    //             title: const Text(
    //               'What is the capital of India?',
    //               style: TextStyle(fontSize: 24),
    //             ),
    //             // subtitle: Text(widget.question['answer']),
    //           ),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           ListView.builder(
    //             scrollDirection: Axis.vertical,
    //             shrinkWrap: true,
    //             itemCount: 4,
    //             itemBuilder: (context, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.only(left: 10, right: 10),
    //                 child: Card(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(15),
    //                     side: const BorderSide(
    //                       color: Colors.blue,
    //                       width: 2,
    //                     ),
    //                   ),
    //                   color: Colors.blue.withOpacity(0.5),
    //                   child: ListTile(
    //                     leading: Text(
    //                       '${String.fromCharCode(65 + index)}.',
    //                       style: const TextStyle(fontSize: 20),
    //                     ),
    //                     title: const Text(
    //                       'New Delhi',
    //                       style: TextStyle(fontSize: 20),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
  }
}
