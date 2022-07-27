import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey _screenShotKey = GlobalKey();
  var code = '';
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(35),
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: title,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: ' Code ',
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.indigo,
                onPressed: () {
                  setState(() {
                    code = title.text;
                  });
                },
                child: Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              code == ''
                  ? Text('')
                  : RepaintBoundary(
                      key: _screenShotKey,
                      child: BarcodeWidget(
                        barcode: Barcode.qrCode(
                          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                        ),
                        data: '$code',
                        width: 200,
                        height: 200,
                      ),
                    ),
              ElevatedButton(onPressed: takeScreenshot, child: Text("jadu")),
              ElevatedButton(onPressed: save, child: Text("jadu"))
            ],
          ),
        ),
      ),
    );
  }

  Future<File> takeScreenshot() async {
    RenderRepaintBoundary boundary = _screenShotKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    final tempPath = (await getTemporaryDirectory()).path;
    final path = tempPath + "qr.png";
    File imgFile = File(path);
    return imgFile.writeAsBytes(pngBytes!);
  }

  void save() async {
    takeScreenshot().then((value) async {
      bool? saved = await GallerySaver.saveImage(value.path);
      print(saved);
    }).catchError((onError) {
      print("error");
    });
  }
}
