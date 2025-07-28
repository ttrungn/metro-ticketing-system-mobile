class PaymentMethod {
  final String title;
  final String assetPath;
  final PaymentType type;

  PaymentMethod({
    required this.title,
    required this.assetPath,
    required this.type,
  });
}

enum PaymentType { Default, Momo }

final List<PaymentMethod> methods = [
  PaymentMethod(
    title: "E-wallet MoMo",
    assetPath: "assets/payment/momo.webp",
    type: PaymentType.Momo,
  ),
];
