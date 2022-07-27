import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyview(),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: const Text("Qr Code Usuage"),
  );
}

Column _bodyview() {
  return Column(
    children: [
      _bodyImage(),
      _twobutton(
          () => {
                // ignore: avoid_print
                print("jadu"),
              },
          "")
    ],
  );
}

Image _bodyImage() {
  return Image.network(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png");
}

ElevatedButton _twobutton(final Function()? onpressed, final String text) {
  return ElevatedButton(onPressed: onpressed, child: Text(text));
}
