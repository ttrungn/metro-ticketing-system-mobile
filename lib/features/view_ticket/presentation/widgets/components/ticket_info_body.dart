import 'package:flutter/material.dart';
import '../../../../../core/constants/app_color.dart';

class TicketInfoBody extends StatelessWidget {
  final String ticketId;
  final String? entryStationName;
  final String? destinationStationName;
  final int status;
  final DateTime? activateDate;
  final DateTime? expireDate;
  final int ticketType;
  final String ticketName;
  final bool isExpired;

  const TicketInfoBody({
    super.key,
    required this.ticketId,
    required this.status,
    required this.entryStationName,
    required this.destinationStationName,
    required this.activateDate,
    required this.expireDate,
    required this.ticketType,
    required this.ticketName,
    this.isExpired = false,
  });

  String _statusText(int status) {
    switch (status) {
      case 0:
        return 'Chưa kích hoạt';
      case 1:
        return 'Đang kích hoạt';
      case 2:
        return 'Hết hạn';
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
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} '
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        _infoRow(
          Icons.confirmation_number,
          'Loại vé:',
          _ticketRouteText(),
        ),
        _infoRow(
          Icons.check_circle_outline,
          'Trạng thái:',
          _statusText(status),
          color: _statusColor(status),
          isStatusRow: true,
        ),
        _infoRow(
          Icons.access_time,
          'Kích hoạt:',
          _formatDateTime(activateDate),
        ),
        _infoRow(
          Icons.event,
          isExpired ? 'Đã sử dụng:' : 'HSD:',
          _formatDateTime(expireDate),
        ),
        _infoRow(
          Icons.warning_amber_rounded,
          'Lưu ý:',
          ticketType == 1
              ? 'Vé sử dụng một lần'
              : 'Vé sử dụng nhiều lần. Hãy chú ý HSD!',
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      {Color? color, bool isStatusRow = false}) {
    if (isStatusRow) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: color ?? ConstantAppColor.primary),
            const SizedBox(width: 5),
            const SizedBox(
              width: 90,
              child: Text(
                'Trạng thái:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            IntrinsicWidth(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: color ?? Colors.black, width: 1.2),
                  borderRadius: BorderRadius.circular(20),
                  color: (color ?? Colors.black).withOpacity(0.1),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    color: color ?? Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Các dòng còn lại dùng Table như cũ
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(), // Icon
          1: FixedColumnWidth(5),    // spacing
          2: FixedColumnWidth(95),  // Label width
          3: FlexColumnWidth(),      // Value column
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            Icon(icon, size: 20, color: color ?? ConstantAppColor.primary),
            const SizedBox(),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              value,
              style: TextStyle(
                color: color ?? Colors.black87,
              ),
            ),
          ])
        ],
      ),
    );
  }




  String _ticketRouteText() {
    final isEntryEmpty = entryStationName == null || entryStationName!.trim().isEmpty;
    final isDestinationEmpty = destinationStationName == null || destinationStationName!.trim().isEmpty;

    if (ticketType == 3) {
      return "Học Sinh, Sinh Viên";
    }
    if (isEntryEmpty || isDestinationEmpty) {
      return ticketName;
    }
    return '$ticketName: $entryStationName - $destinationStationName';
  }


  }

