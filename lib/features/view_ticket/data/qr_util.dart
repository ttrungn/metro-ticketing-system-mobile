import 'dart:convert';

String generateQRData(String id, String ticketId) {
  final now = DateTime.now().toIso8601String();

  return jsonEncode({"id": id, "ticketId": ticketId, "generatedAt": now});
}
