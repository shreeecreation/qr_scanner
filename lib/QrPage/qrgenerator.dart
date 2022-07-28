import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home/Bloc/bloc/home_bloc.dart';

class QrGenerator extends StatefulWidget {
  QrGenerator({Key? key}) : super(key: key);

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  final GlobalKey _screenShotKey = GlobalKey();

  var code = '';

  bool show_generate_qr = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              show_generate_qr
                  ? BarcodeWidget(
                      barcode: Barcode.qrCode(
                        errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                      ),
                      data: code,
                      width: 200,
                      height: 200,
                    )
                  : Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png",
                      height: 250,
                      width: 250,
                    ),
              Padding(
                padding: const EdgeInsets.all(35),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    controller: title,
                    decoration: InputDecoration(
                      labelText: "Enter Your Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: Colors.cyan, width: 1),
                  ),
                  onPressed: () {
                    code = title.text;
                    setState(() {
                      show_generate_qr = true;
                    });
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(HomeInitialEvent());
                      },
                      child: const Text("Back")),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: null, child: const Text("Download"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
