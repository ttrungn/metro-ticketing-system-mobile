import 'package:injectable/injectable.dart';
import 'qr_repository.dart';

@lazySingleton
class QRService {
  final QRRepository _qrRepository;

  QRService(this._qrRepository);

  Future<QRUpdateResult> markTicketAsUsed(String id, String ticketId) async {
    return await _qrRepository.updateTicketStatusToUse(id, ticketId);
  }

  Future<QRUpdateResult> markTicketAsExited(String id, String ticketId) async {
    return await _qrRepository.updateTicketStatusExit(id, ticketId);
  }
}
