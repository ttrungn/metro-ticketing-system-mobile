import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/features/view_ticket/presentation/widgets/components/ticket_info_body.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../data/qr_util.dart';
import '../../../../../core/constants/app_color.dart';


class TicketQRView extends StatefulWidget {
  final String orderId;
  final String ticketId;
  final String ticketName;
  final String? entryStationName;
  final String? destinationStationName;
  final int status;
  final DateTime? activateDate;
  final DateTime? expireDate;
  final int ticketType;

  const TicketQRView({
    super.key,
    required this.orderId,
    required this.ticketId,
    required this.ticketName,
    required this.status,
    this.entryStationName,
    this.destinationStationName,
    this.activateDate,
    this.expireDate,
    required this.ticketType,
  });

  @override
  State<TicketQRView> createState() => TicketQRViewState();
}

class TicketQRViewState extends State<TicketQRView> {
  String? qrData;
  late Timer _timer;
  int countdown = 40;
  bool showQR = true;

  String _statusText(int status) {
    switch (status) {
      case 0:
        return 'Chưa kích hoạt';
      case 1:
        return 'Đang kích hoạt';
      case 2:
        return 'Đã sử dụng';
      default:
        return 'Không rõ';
    }
  }
  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.green;
      case 2:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  String _formatDateTime(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')} '
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  void initState() {
    super.initState();
    _generateNewQR();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
        if (countdown <= 0) {
          _generateNewQR();
          countdown = 40;
        }
      });
    });
  }

  void _generateNewQR() {
    setState(() {
      qrData = generateQRData(widget.orderId, widget.ticketId);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 450,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blueGrey.shade100, width: 2.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRouteTitle(),
              const SizedBox(height: 15),
              _buildQRContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRContent() {
    return Container(
      decoration: BoxDecoration(
        color: ConstantAppColor.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      child: Column(
        children: [
          _buildToggleButtons(),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 350,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: showQR ? _buildQRCodeSection() : _buildInfoSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          '*Vui lòng không đưa mã cho người khác sử dụng',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: QrImageView(
            data: qrData ?? '',
            version: QrVersions.auto,
            size: 220,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mã sẽ hết hạn sau: ${countdown}s',
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        const Icon(Icons.sync, size: 18, color: Colors.grey),
      ],
    );
  }

  Widget _buildInfoSection() {
    return TicketInfoBody(
      ticketId: widget.ticketId,
      status: widget.status,
      entryStationName: widget.entryStationName,
      destinationStationName: widget.destinationStationName,
      activateDate: widget.activateDate,
      expireDate: widget.expireDate,
      ticketType: widget.ticketType,
      ticketName: widget.ticketName,
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: ConstantAppColor.primary),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildTabButton('Mã QR', showQR, () => setState(() => showQR = true)),
          _buildTabButton('Thông tin', !showQR, () => setState(() => showQR = false)),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? ConstantAppColor.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
  String _ticketRouteText() {
    final isEntryEmpty = widget.entryStationName == null || widget.entryStationName!.trim().isEmpty;
    final isDestinationEmpty = widget.destinationStationName == null || widget.destinationStationName!.trim().isEmpty;

    if (isEntryEmpty || isDestinationEmpty) {
      return widget.ticketName;
    }
    return '${widget.ticketName}: ${widget.entryStationName} - ${widget.destinationStationName}';
  }



  Widget _buildRouteTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.train, color: ConstantAppColor.primary),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            _ticketRouteText(),
             style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}