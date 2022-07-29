import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/scaffoldmessenger.dart';

class Result extends StatelessWidget {
  const Result({Key? key, required this.result}) : super(key: key);
  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text("Result",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )),
        const SizedBox(height: 50),
        Container(
            height: 300,
            width: 250,
            color: const Color.fromARGB(97, 253, 232, 232),
            child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: Colors.white54,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(result,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.green,
                            )),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: result));
                              ShowScaffold(context, "Copied to Clipboard");
                            },
                            child: const Text("Copy"))
                      ],
                    ),
                  ),
                ))),
      ]),
    );
  }
}
