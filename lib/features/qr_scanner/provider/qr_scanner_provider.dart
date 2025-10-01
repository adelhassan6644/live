import 'package:flutter/material.dart';
import 'package:live/features/qr_scanner/repo/qr_scanner_repo.dart';
import 'package:live/components/custom_simple_dialog.dart';
import 'package:live/app/localization/localization/language_constant.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:live/components/custom_button.dart';

class QrScannerProvider extends ChangeNotifier {
  QrScannerRepo qrScannerRepo;
  QrScannerProvider({required this.qrScannerRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _lastScannedData;
  String? get lastScannedData => _lastScannedData;

  Future<void> sendQrDataToServer(String qrData) async {
    _isLoading = true;
    _lastScannedData = qrData;
    notifyListeners();

    try {
      final result = await qrScannerRepo.sendQrData(qrData);
      result.fold(
        (failure) {
          // Handle error
          debugPrint('QR Scanner Error: ${failure.error}');
          _showErrorDialog(failure.error ?? 'Unknown error occurred');
        },
        (response) {
          // Handle success
          debugPrint('QR Data sent successfully: ${response.data}');
          _showSuccessDialog();
        },
      );
    } catch (e) {
      debugPrint('QR Scanner Exception: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showSuccessDialog() {
    final context = CustomNavigator.navigatorState.currentContext;
    if (context == null) return;

    CustomSimpleDialog.parentSimpleDialog(
      customListWidget: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 60,
        ),
        const SizedBox(height: 16),
        Text(
          getTranslated("qr_code_applied_success", context),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: getTranslated("ok", context),
          onTap: () => CustomNavigator.pop(),
        ),
      ],
    );
  }

  void _showErrorDialog(String errorMessage) {
    final context = CustomNavigator.navigatorState.currentContext;
    if (context == null) return;

    CustomSimpleDialog.parentSimpleDialog(
      customListWidget: [
        const Icon(
          Icons.error,
          color: Colors.red,
          size: 60,
        ),
        const SizedBox(height: 16),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: getTranslated("ok", context),
          onTap: () => CustomNavigator.pop(),
        ),
      ],
    );
  }
}
