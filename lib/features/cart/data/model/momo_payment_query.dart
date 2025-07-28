class PaymentQuery {
  final String partnerCode;
  final String orderId;
  final String requestId;
  final int amount;
  final String orderInfo;
  final String orderType;
  final String transId;
  final String resultCode;
  final String message;
  final String payType;
  final String responseTime;
  final String signature;
  final String extraData;

  PaymentQuery({
    required this.partnerCode,
    required this.orderId,
    required this.requestId,
    required this.amount,
    required this.orderInfo,
    required this.orderType,
    required this.transId,
    required this.resultCode,
    required this.message,
    required this.payType,
    required this.responseTime,
    required this.signature,
    required this.extraData,
  });

  factory PaymentQuery.fromQueryParameters(Map<String, String> params) {
    return PaymentQuery(
      partnerCode: params['partnerCode'] ?? '',
      orderId: params['orderId'] ?? '',
      requestId: params['requestId'] ?? '',
      amount: int.tryParse(params['amount'] ?? '0') ?? 0,
      orderInfo: params['orderInfo'] ?? '',
      orderType: params['orderType'] ?? '',
      transId: params['transId'] ?? '',
      resultCode: params['resultCode'] ?? '',
      message: params['message'] ?? '',
      payType: params['payType'] ?? '',
      responseTime: params['responseTime'] ?? '',
      signature: params['signature'] ?? '',
      extraData: params['extraData'] ?? '',
    );
  }
}
