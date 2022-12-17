// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/QrPage/qrscanner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Home/Bloc/bloc/home_bloc.dart';
import '../Home/home.dart';
import 'qrgenerator.dart';

class DefaultQr extends StatelessWidget {
  DefaultQr({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: WillPopScope(
        onWillPop: () {
          LogOutPop(context);
          return new Future(() => false);
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: _appBar(),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial) {
                  return const MyHomePage();
                }
                if (state is HomeQrCreateState) {
                  return QrGenerator();
                }
                if (state is HomeQrScanState) {
                  return QrScannerPage();
                }
                return Center(child: Text("Its a scanner page"));
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.cyan,
      title: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: const Text("Code Scanner"),
      )),
      automaticallyImplyLeading: true,
      actions: [
        PopupMenuButton(itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text("Privacy Policy"),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text("Rate Us"),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text("More Apps"),
            ),
          ];
        }, onSelected: (value) async {
          if (value == 0) {
            if (await canLaunch(
                "https://sites.google.com/view/createscanqrcode/home")) {
              await launch(
                  "https://sites.google.com/view/createscanqrcode/home");
            }
          } else if (value == 1) {
            if (await canLaunch(
                "https://play.google.com/store/apps/details?id=com.kiddiecreation.eco")) {
              await launch(
                  "https://play.google.com/store/apps/details?id=com.kiddiecreation.eco");
            }
          } else if (value == 2) {
            if (await canLaunch(
                "https://play.google.com/store/apps/developer?id=Shreee_Creation")) {
              await launch(
                  "https://play.google.com/store/apps/developer?id=Shreee_Creation");
            }
          }
        }),
      ],
    );
  }
}

void LogOutPop(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: Text("Exit !"),
              content: Text(" Didn't enjoyed ???"),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text('Exit'),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ]));
}
