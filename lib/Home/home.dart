import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';

import '../QrPage/_defaultqrpage.dart';
import 'Bloc/bloc/home_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        // appBar: _appBar(),
        body: _bodyview(context),
      ),
    );
  }
}

Column _bodyview(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: mark()),
        ],
      ),
      SizedBox(height: 50),
      _bodyImage(),
      const SizedBox(height: 50),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          height: 50,
          child: _twobutton(
              () => {
                    BlocProvider.of<HomeBloc>(context).add(HomeQrCreateEvent()),
                  },
              "Create a Qr Code"),
        ),
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.1,
        height: 50,
        child: _twobutton(
            () => {
                  BlocProvider.of<HomeBloc>(context).add(HomeQrScanEvent()),
                },
            "Scan a Qr Code"),
      )
    ],
  );
}

ClipRRect _bodyImage() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12.0),
    child: Image.network(
      "https://img.freepik.com/free-vector/qr-code-scan-mobile-style_23-2148638220.jpg?w=2000",
      height: 250.0,
      width: 250.0,
    ),
  );
  // return Image.network(
  //   "https://img.freepik.com/free-vector/qr-code-scan-mobile-style_23-2148638220.jpg?w=2000",
  //   height: 250,
  //   width: 250,
  // );
}

OutlinedButton _twobutton(final Function()? onpressed, final String text) {
  return OutlinedButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        side: const BorderSide(color: Colors.cyan, width: 1),
      ));
}

Marquee mark() {
  return Marquee(
      text: 'SCAN AND CREATE A QR CODE IN A SECOND             ',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
}
