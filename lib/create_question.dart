import 'package:flutter/material.dart';

class CreateQuestion extends StatefulWidget {
  const CreateQuestion({super.key});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  List<String> options = [''];
  void addTextField() {
    if (options.last.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Please fill the previous option',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
      return;
    }
    setState(() {
      options.add('');
    });
  }

  void removeTextField(int index) {
    setState(() {
      options.removeAt(index);
    });
  }

  void updateText(String text, int index) {
    // setState(() {
    options[index] = text;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create quiz question'),
      ),
      body: GestureDetector(
        onHorizontalDragCancel: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            // Container(
            //   constraints: BoxConstraints(
            //     maxHeight: MediaQuery.of(context).size.height - 100,
            //     maxWidth: MediaQuery.of(context).size.width - 30,
            //   ),
            //   child: const TextField(
            //     decoration: InputDecoration(
            //       border: UnderlineInputBorder(
            //         borderSide: BorderSide(width: 2),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //       ),
            //       hintText: 'Enter question',
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9),
                contentPadding: const EdgeInsets.all(20),
                border: const OutlineInputBorder(), // Adds an outline border
                labelText: 'Enter your name', // Adds a label
                // focusedBorder: const OutlineInputBorder(
                //     // Border when the TextField is focused
                //     // borderSide: BorderSide(color: Colors.green, width: 2.0),
                //     ),
                prefixIcon: const Icon(Icons
                    .question_mark_sharp), // Adds an icon inside the TextField
                // You can customize further with properties like hintText, filled, fillColor, etc.
              ),
            ),
            const SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(
                maxHeight: 60,
                maxWidth: MediaQuery.of(context).size.width * 0.7,
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
                  padding: const EdgeInsets.all(1.0),
                  child: GestureDetector(
                    onTap: () {
                      addTextField();
                    },
                    child: TextButton.icon(
                      onPressed: () {
                        addTextField();
                      },
                      label: const Text('Add new option'),
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                      ),
                    ),
                    // const ListTile(
                    //   leading: Icon(
                    //     Icons.add_circle,
                    //     color: Colors.blue,
                    //   ),
                    //   title: Text('Add new option'),
                    // ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              // height: double.maxFinite,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
                // maxWidth: MediaQuery.of(context).size.width - 30,
                minHeight: 10,
                // minWidth:
              ),
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: TextField(
                      onChanged: (text) => updateText(text, index),
                      controller: TextEditingController(text: options[index]),
                    ),
                    leading: Text((index + 1).toString(),
                        style: const TextStyle(fontSize: 22)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => removeTextField(index),
                    ),
                  );
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: addTextField,
            //   child: const Text('Add Option'),
            // ),
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance.collection(code).snapshots(),
            //   // initialData: initialData,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Text('Loading...');
            //     }
            //     if (snapshot.error is FirebaseException) {
            //       FirebaseException error = snapshot.error as FirebaseException;
            //       // Handle FirebaseException specifically
            //       return Text('Firebase Error: ${error.message}');
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
