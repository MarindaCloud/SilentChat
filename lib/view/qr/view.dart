import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logic.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrPage extends StatelessWidget {
  QrPage({Key? key}) : super(key: key);

  final logic = Get.find<QrLogic>();
  final state = Get
      .find<QrLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrLogic>(builder: (logic) {
      return Scaffold(
        body: MobileScanner(
          onDetect: (capture){
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
          },
        ),
      );
    });
  }
}
