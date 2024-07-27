import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slido/create/create_question.dart';
import 'package:slido/interaction/create_qr.dart';
import 'package:slido/interaction/interactive_mode.dart';

class CreateSlido extends StatefulWidget {
  const CreateSlido({super.key});

  @override
  State<CreateSlido> createState() => _CreateSlidoState();
}

class _CreateSlidoState extends State<CreateSlido> {
  String? email;
  SharedPreferences? prefs;
  void sharedPrefs() async {
    print('sharedPrefs');
    prefs = await SharedPreferences.getInstance();

    // await prefs?.setString('email', '100');
    print(prefs?.getString('email'));
    email = prefs?.getString('email') ?? '';
    // print(email);
  }

  @override
  void initState() {
    print('init');
    super.initState();
    sharedPrefs();
  }

  // final String code = '100';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InteractiveMode(),
                  ));
            },
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
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(email)
                  // .collection('questions')c
                  .snapshots(),
              // snapshot.data.docs.sort((a, b) => a['question'].compareTo(b['question']));

              // initialData: initialData,
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
                    FirebaseException error =
                        snapshot.error as FirebaseException;
                    return Text('Firebase Error: ${error.message}');
                  }
                }
                // print(snapshot.data.data());
                var documentData = snapshot.data.data();
                print(documentData);
                print(documentData.runtimeType);
                print('hehe');
                // return const Text('Loading...');
                // print(documentData);
                documentData = documentData['questions'];
                if (documentData == null) {
                  return const Center(
                    // padding:  EdgeInsets.all(8.0),
                    child: Text('No questions added',
                        style: TextStyle(fontSize: 16)),
                  );
                }
                return SingleChildScrollView(
                    child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                    maxWidth: MediaQuery.of(context).size.width - 30,
                  ),
                  child: ListView.builder(
                    itemCount: documentData.length,
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
                              // var dataSnapshot = snapshot.data.docs[index];
                              var fireData = {
                                'question': documentData[index]['question'],
                                'correct': documentData[index]['correct'],
                                'id': documentData[index]['id'],
                                'options': documentData[index]['options']
                              };
                              // print(fireData);
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
                              title: Text(documentData[index]['question']),
                              subtitle: Text(
                                  'Options: ${documentData[index]['options'].length.toString()}'),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Delete Question'),
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
                                                    .collection('users')
                                                    .doc(email)
                                                    .update({
                                                  'noOfQuestions':
                                                      FieldValue.increment(-1),
                                                  'questions':
                                                      FieldValue.arrayRemove([
                                                    {
                                                      'correct':
                                                          documentData[index]
                                                              ['correct'],
                                                      'id': documentData[index]
                                                          ['id'],
                                                      'options':
                                                          documentData[index]
                                                              ['options'],
                                                      'question':
                                                          documentData[index]
                                                              ['question']
                                                    }
                                                    // documentData[index]
                                                    //     ['question'],
                                                  ])
                                                });
                                                // FirebaseFirestore.instance
                                                //     .collection(email)
                                                //     .doc(snapshot
                                                //         .data.docs[index].id)
                                                //     .delete();
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
