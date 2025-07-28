import 'package:injectable/injectable.dart';
import 'package:metro_ticketing_system_mobile/core/configs/api_client.dart';

@lazySingleton
class QRRepository {
  QRRepository();

  Future<QRUpdateResult> updateTicketStatusToUse(
    String orderId,
    String ticketId,
  ) async {
    try {
      final response = await ApiClient.dio.put(
        "/order/Orders/update-ticket-to-used",
        data: {"id": orderId, "ticketId": ticketId},
      );
      final json = response.data;
      final succeeded = json['succeeded'];
      final message = json['message'];
      final id = json['data'];
      return QRUpdateResult(success: succeeded, message: message, id: id);
    } catch (e) {
      throw (" Lỗi khi cập nhật vé: $e");
    }
  }

  Future<QRUpdateResult> updateTicketStatusExit(
    String orderId,
    String ticketId,
  ) async {
    try {
      final response = await ApiClient.dio.put(
        "/order/Orders/update-ticket-to-unused-or-expired",
        data: {"id": orderId, "ticketId": ticketId},
      );
      final json = response.data;
      final succeeded = json['succeeded'];
      final message = json['message'];
      final id = json['data'];
      return QRUpdateResult(success: succeeded, message: message, id: id);
    } catch (e) {
      throw (" Lỗi khi cập nhật vé: $e");
    }
  }
}

class QRUpdateResult {
  final bool success;
  final String message;
  final String? id;

  QRUpdateResult({required this.success, required this.message, this.id});
}
