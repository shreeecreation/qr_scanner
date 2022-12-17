import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home/Bloc/bloc/home_bloc.dart';
import 'reultpage.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  late String value;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
                },
                icon: Icon(Icons.arrow_back))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  child: OutlinedButton(
                      onPressed: () {
                        scanQr(ScanMode.QR);
                      },
                      child: const Text(
                        "Qr Code Scanner",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: Colors.cyan, width: 1),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  child: OutlinedButton(
                      onPressed: () {
                        scanQr(ScanMode.BARCODE);
                      },
                      child: const Text(
                        "Bar - Code Scanner",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: Colors.cyan, width: 1),
                      )),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> scanQr(ScanMode scan) async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, scan)
          .then((value) {
        setState(() {
          value = value;
          if (value == "-1") {
            BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
          } else {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: Result(
                        result: value,
                      ),
                    ));
          }
        });
      });
    } catch (e) {
      setState(() {
        value = 'unable to read this';
      });
    }
  }
}
