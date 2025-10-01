import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:live/app/core/utils/color_resources.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:live/data/config/di.dart';
import 'package:live/features/qr_scanner/provider/qr_scanner_provider.dart';
import 'package:live/components/custom_button.dart';
import 'package:provider/provider.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFlashOn = false;
  bool isScanning = true;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sl<QrScannerProvider>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => CustomNavigator.pop(),
          ),
          title: Text(
            getTranslated("qr_scanner", context),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
              ),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {
                  isFlashOn = !isFlashOn;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: ColorResources.PRIMARY_COLOR,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300,
                    ),
                    onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                  ),
                  // Scanning instruction overlay
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        getTranslated("qr_scanner_instruction", context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.black,
                height: 200,
                child: Consumer<QrScannerProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (result != null) ...[
                          Expanded(
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      getTranslated("scanned_result", context),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    CustomButton(
                                      text: getTranslated("scan_again", context),
                                      backgroundColor: ColorResources.PRIMARY_COLOR,
                                      textColor: Colors.white,
                                      height: 50,
                                      width: 200,
                                      onTap: () {
                                        setState(() {
                                          result = null;
                                          isScanning = true;
                                        });
                                        controller?.resumeCamera();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ] else ...[
                          Text(
                            getTranslated("scan_qr_code", context),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Check if we're still in scanning mode to prevent multiple scans
      if (!isScanning) return;

      // Immediately stop scanning to prevent multiple calls
      isScanning = false;

      // Stop camera immediately when any QR data is detected
      controller.pauseCamera();

      debugPrint('QR Code scanned: ${scanData.code}');

      setState(() {
        result = scanData;
      });

      // Send the scanned data to API
      if (scanData.code != null && mounted) {
        try {
          final provider = sl<QrScannerProvider>();
          provider.sendQrDataToServer(scanData.code!);
        } catch (e) {
          debugPrint('Error getting QrScannerProvider: $e');
          // Fallback - show success message without API call
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('QR Code scanned: ${scanData.code}'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }
}
