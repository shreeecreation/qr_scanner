import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/QrPage/qrscanner.dart';

import '../Home/Bloc/bloc/home_bloc.dart';
import '../Home/home.dart';
import '../first.dart';
import 'qrgenerator.dart';

class DefaultQr extends StatelessWidget {
  DefaultQr({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
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
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.cyan,
      title: Center(child: const Text("Code Scanner")),
      automaticallyImplyLeading: true,
    );
  }
}
