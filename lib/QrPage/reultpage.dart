import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({Key? key, required this.result}) : super(key: key);
  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(children: [
        Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.cyan,
            child: const Center(
              child: Text("Result",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )),
        const SizedBox(height: 50),
        Container(
            height: 300,
            width: 250,
            color: Color.fromARGB(97, 253, 232, 232),
            child: Card(
                color: Colors.white54,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(result,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                        )),
                  ),
                ))),
      ]),
    );
  }
}
