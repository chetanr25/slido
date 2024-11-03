import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slido/Providers/shared_preferences_provider.dart';
import 'package:slido/screen/interaction/interactive_mode.dart';
import 'package:slido/widgets/add_questions.dart';
import 'package:slido/widgets/questions_list.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});
  // String? email; //= 'che@gm.com';
  // SharedPreferences? prefs;
  // bool isloading = true;
  // void sharedPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   email = prefs?.getString('email') ?? '';
  //   setState(() {
  //     isloading = false;
  //   });
  // }

  // @override
  // void initState() {

  //   super.initState();
  //   // sharedPrefs();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final prefs = ref.watch(sharedPreferencesProvider);
    // final String email = ref.watch(emailProvider)!;

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
              child: const Text('Start interaction'),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Create Slido'),
          actions: [
            IconButton(
              onPressed: () {
                logout(ref, context);
                // signout(prefs, context);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AddQuestions(),
              const SizedBox(height: 10),
              QuestionsList()
            ],
          ),
        )
        // : const Center(child: CircularProgressIndicator()),
        );
  }
}

// void signout(prefs, context) {
//   prefs?.remove('email');
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const Auth(),
//     ),
//   );
// }
