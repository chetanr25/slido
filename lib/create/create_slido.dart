import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slido/create/create_question.dart';

class CreateSlido extends StatefulWidget {
  const CreateSlido({super.key});

  @override
  State<CreateSlido> createState() => _CreateSlidoState();
}

class _CreateSlidoState extends State<CreateSlido> {
  final String code = '100';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.5),
              side: BorderSide(
                  style: BorderStyle.solid,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  width: 2),
            ),
            child: const Text('Start interaction'),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Create Slido'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 100,
                maxWidth: MediaQuery.of(context).size.width - 30,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blue.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateQuestion()));
                      // Navigator.pushNamed(context, '/create_question');
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                      ),
                      title: Text('Add Question'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection(code).snapshots(),
              // initialData: initialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }
                if (snapshot.error is FirebaseException) {
                  FirebaseException error = snapshot.error as FirebaseException;
                  // Handle FirebaseException specifically
                  return Text('Firebase Error: ${error.message}');
                }
                if (snapshot.hasError) {
                  if (snapshot.error is FirebaseException) {
                    FirebaseException error =
                        snapshot.error as FirebaseException;
                    // Handle FirebaseException specifically
                    return Text('Firebase Error: ${error.message}');
                  }
                  // return const Text('Error');
                }
                if (snapshot.data.docs.length == 0) {
                  return const Text('No questions added');
                }
                return SingleChildScrollView(
                    child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                    maxWidth: MediaQuery.of(context).size.width - 30,
                  ),
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
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
                              // Navigator.pushNamed(context, '/home');
                            },
                            child: GestureDetector(
                              onTap: () {
                                var dataSnapshot = snapshot.data.docs[index];
                                var fireData = {
                                  'question': dataSnapshot['question'],
                                  'correct': dataSnapshot['correct'],
                                  'id': dataSnapshot['id'],
                                  'options': dataSnapshot['options']
                                };
                                // print(fireData);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CreateQuestion(fireData: fireData
                                            // snapshot.data.docs[index],
                                            ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(fontSize: 22),
                                ),
                                title:
                                    Text(snapshot.data.docs[index]['question']),
                                subtitle: Text(
                                    'Options: ${snapshot.data.docs[index]['options'].length.toString()}'),
                                trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Delete Question'),
                                            content: const Text(
                                                'Are you sure you want to delete this question?'),
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
                                                  FirebaseFirestore.instance
                                                      .collection(code)
                                                      .doc(snapshot
                                                          .data.docs[index].id)
                                                      .delete();
                                                },
                                                label: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                                // );
                              ),
                            ),
                          ));
                    },
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
