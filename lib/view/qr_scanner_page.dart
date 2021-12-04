// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerPage extends StatefulWidget {
//   const QRScannerPage({Key? key}) : super(key: key);

//   @override
//   _QRScannerPageState createState() => _QRScannerPageState();
// }

// class _QRScannerPageState extends State<QRScannerPage> {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
//     Barcode? result;
//     QRViewController? _qrViewController;

//     // In order to get hot reload to work we need to pause the camera if the platform
//     // is android, or resume the camera if the platform is iOS.
//     @override
//     void reassemble() {
//       super.reassemble();
//       if (Platform.isAndroid) {
//         _qrViewController!.pauseCamera();
//       } else if (Platform.isIOS) {
//         _qrViewController!.resumeCamera();
//       }
//     }

//     void onQRViewCreated(QRViewController controller) {
//       _qrViewController = controller;
//       controller.scannedDataStream.listen((scanData) {
//         setState(() {
//           result = scanData;
//         });
//       });
//     }

//     @override
//     void dispose() {
//       _qrViewController?.dispose();
//       super.dispose();
//     }

//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           QRView(
//             key: qrKey,
//             onQRViewCreated: onQRViewCreated,
//           ),
//           Center(
//             child: (result != null)
//                 ? Text(
//                     'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                 : Text('Scan a code'),
//           )
//         ],
//       ),
//     );
//   }
// }
