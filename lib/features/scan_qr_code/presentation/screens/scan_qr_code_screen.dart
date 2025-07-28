import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/screens/error_screen.dart';
import 'package:metro_ticketing_system_mobile/features/scan_qr_code/data/qr_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:metro_ticketing_system_mobile/core/di/service_locator.dart';

import '../../../../core/constants/app_color.dart';

class ScanQRCodeScreen extends StatefulWidget {
  const ScanQRCodeScreen({super.key});

  @override
  State<ScanQRCodeScreen> createState() => ScanQRCodeScreenState();
}

class ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
  bool isScanned = false;
  final MobileScannerController controller = MobileScannerController();
  final QRService qrService = getIt<QRService>();

  void _onDetect(BarcodeCapture capture) async {
    if (isScanned) return;

    final Barcode barcode = capture.barcodes.first;
    final String? code = barcode.rawValue;

    if (code == null) {
      _showResultDialog("Không thể đọc mã QR");
      return;
    }

    setState(() => isScanned = true);

    try {
      final Map<String, dynamic> data = jsonDecode(code);
      final id = data['id'];
      final ticketId = data['ticketId'];
      final expiredAt = DateTime.parse(data['generatedAt']);

      if (DateTime.now().difference(expiredAt).inSeconds > 40) {
        _showResultDialog("Mã QR đã hết hạn", isSuccess: false);
        return;
      }

      final result = await qrService.markTicketAsUsed(id, ticketId);

      if (result.success) {
        _showResultDialog("Vé Hợp Lệ!", isSuccess: true);
      } else {
        _showResultDialog(result.message, isSuccess: false);
      }
    } catch (e) {
      _showResultDialog(
        "Vé không hợp lệ hoặc đã được sử dụng vào trước đó!",
        isSuccess: false,
      );
    }
  }

  void _showResultDialog(String message, {bool isSuccess = false}) {
    final bgColor = isSuccess ? Colors.green.shade50 : Colors.red.shade50;
    final borderColor = isSuccess ? Colors.green : Colors.red;
    final textColor = isSuccess ? Colors.green.shade900 : Colors.red.shade900;
    final icon = isSuccess ? Icons.check_circle_outline : Icons.error_outline;
    final iconColor = isSuccess ? Colors.green : Colors.red;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(icon, color: iconColor),
                SizedBox(width: 8),
                Text("Kết quả"),
              ],
            ),
            content: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.start();
                  setState(() => isScanned = false);
                },
                child: Text("Quét lại", style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ErrorScreen(),
                      ),
                    ),
                child: Text("Xong", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Quét Vào", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: ConstantAppColor.primaryLight,
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 24),
            Expanded(
              flex: 4,
              child: Center(
                child: Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        MobileScanner(
                          controller: controller,
                          onDetect: _onDetect,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.qr_code_scanner,
                              size: 48,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Hướng camera vào mã QR để quét',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
