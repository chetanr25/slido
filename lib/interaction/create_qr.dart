import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CreateSlidoQr extends StatefulWidget {
  CreateSlidoQr({super.key, this.textData = 'google.com'});
  var textData;

  @override
  State<CreateSlidoQr> createState() => _CreateSlidoQrState();
}

class _CreateSlidoQrState extends State<CreateSlidoQr> {
  String email = '';

  SharedPreferences? prefs;

  void sharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs?.getString('email') ?? 'chetan250204@gmail.com';
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Scan Qr to start interacting'),
      // ),

      body: Container(
        alignment: Alignment.center,
        child: Card(
          color: Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Colors.white,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          // shadowColor: Colors.white,
          // elevation: 6,
          // semanticContainer: false,
          // color: Colors.red,
          // borderOnForeground: false,
          margin: const EdgeInsets.all(25),
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Gap(40),
                Card(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                      maxWidth: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: QrImageView(
                      data: widget.textData,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.white,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  // margin: EdgeInsets.all(10),
                  // shadowColor: Colors.white,
                  // elevation: 12,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.65),
                    // margin: const EdgeInsets.only(left: 30, right: 30),
                    // padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: TextEditingController(text: widget.textData),
                      readOnly: true,
                      // enabled: false,
                      // style: const TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 20,
                      // ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.5),
                        side: BorderSide(
                            style: BorderStyle.solid,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            width: 2),
                      ),
                      onPressed: () {},
                      label: const Text('Copy link'),
                      icon: const Icon(Icons.link),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.5),
                        side: BorderSide(
                            style: BorderStyle.solid,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            width: 2),
                      ),
                      onPressed: () {},
                      label: const Text('Share link'),
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
                // const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
