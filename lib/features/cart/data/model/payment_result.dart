class PaymentResult {
  final bool isConfirm;
  final int ticketCount;
  final String message;

  PaymentResult({
    required this.isConfirm,
    required this.ticketCount,
    required this.message,
  });

  factory PaymentResult.fromJson(Map<String, dynamic> json) {
    return PaymentResult(
      isConfirm: json['succeeded'] == true,
      ticketCount: json['data']?['ticketCount'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
