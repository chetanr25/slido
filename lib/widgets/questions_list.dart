import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slido/Providers/shared_preferences_provider.dart';
import 'package:slido/screen/create/create_question.dart';

// class QuestionsList extends StatefulWidget {
//   const QuestionsList({super.key, required this.email});
//   final String email;
//   @override
//   State<QuestionsList> createState() => _QuestionsListState();
// }

class QuestionsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider)!;

    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(email).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (snapshot.error is FirebaseException) {
          FirebaseException error = snapshot.error as FirebaseException;
          return Text('Firebase Error: ${error.message}');
        }
        if (snapshot.hasError) {
          if (snapshot.error is FirebaseException) {
            FirebaseException error = snapshot.error as FirebaseException;
            return Text('Firebase Error: ${error.message}');
          }
        }

        Map<String, dynamic> documentData = snapshot.data.data();
        List<Map<String, dynamic>> questions =
            List<Map<String, dynamic>>.from(documentData['questions']);
        if (questions.isEmpty) {
          return const Center(
            child: Text('No questions added', style: TextStyle(fontSize: 16)),
          );
        }
        return SingleChildScrollView(
            child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            maxWidth: MediaQuery.of(context).size.width - 30,
          ),
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: Colors.blue.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue.withOpacity(0.5),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      var fireData = {
                        'question': questions[index]['question'],
                        'correct': questions[index]['correct'],
                        'id': questions[index]['id'],
                        'options': questions[index]['options']
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreateQuestion(fireData: fireData),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: const TextStyle(fontSize: 22),
                      ),
                      title: Text(questions[index]['question']),
                      subtitle: Text(
                          'Options: ${questions[index]['options'].length.toString()}'),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deleteConfirmation(
                                questions, index, context, email);
                          }),
                    ),
                  ));
            },
          ),
        ));
      },
    );
  }
}

void deleteConfirmation(questions, index, context, email) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Question'),
        content: const Text('Are you sure you want to delete this question?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.warning,
              color: Colors.white,
              size: 20,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              FirebaseFirestore.instance.collection('users').doc(email).update({
                'noOfQuestions': FieldValue.increment(-1),
                'questions': FieldValue.arrayRemove([
                  {
                    'correct': questions[index]['correct'],
                    'id': questions[index]['id'],
                    'options': questions[index]['options'],
                    'question': questions[index]['question']
                  }
                ])
              });
            },
            label: const Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
