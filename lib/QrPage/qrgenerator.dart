import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qrcode/Utils/scaffoldmessenger.dart';
import 'package:share_plus/share_plus.dart';
import '../Home/Bloc/bloc/home_bloc.dart';

class QrGenerator extends StatefulWidget {
  QrGenerator({Key? key}) : super(key: key);

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  TextEditingController title = TextEditingController();
  var savepath;
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
                  ? Container(
                      color: Colors.white,
                      child: RepaintBoundary(
                        key: _screenShotKey,
                        child: Container(
                          color: Colors.white,
                          child: BarcodeWidget(
                            barcode: Barcode.qrCode(
                              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                            ),
                            data: code,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    )
                  : Image.asset(
                      "assets/qr.png",
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
                      FocusScope.of(context).unfocus();
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(HomeInitialEvent());
                        FocusScope.of(context).unfocus();
                      },
                      child: const Text("    Back    ")),
                  const SizedBox(width: 60),
                  ElevatedButton(
                      onPressed: () {
                        save(context);
                        FocusScope.of(context).unfocus();
                      },
                      child: const Text("Download"))
                ],
              ),
              const SizedBox(width: 20, height: 20),
              ElevatedButton(
                  onPressed: () {
                    share(context);
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text("Share In App"))
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> takeScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _screenShotKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempPath = (await getApplicationDocumentsDirectory()).path;
      final path = tempPath + "qr.png";
      savepath = path;
      File imgFile = File(path);
      return imgFile.writeAsBytes(pngBytes);
    } catch (e) {
      print("dasdas");
    }
  }

  void save(BuildContext context) async {
    takeScreenshot().then((value) async {
      bool? saved = await GallerySaver.saveImage(value!.path);
      ShowScaffold(context, "Downloaded to Gallery");
    }).catchError((onError) {
      ShowScaffold(context, "Error Saving to Gallery");
    });
  }

  void share(BuildContext context) async {
    takeScreenshot().then((value) async {
      bool? saved = await GallerySaver.saveImage(value!.path);
      Share.shareFiles([savepath], text: "");
    }).catchError((onError) {
      ShowScaffold(context, "Error Saving to Gall1ery and Sharing");
    });
  }
}
