import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

import '../../../../core/common/model/payment_model.dart';
import '../../../../core/common/presentation/widgets/ticket_widgets/ticket_box.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  PaymentMethod? selectedMethod;

  void showPayment() async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Chọn Phương Thức",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: 8),
                ...methods.map(
                  (method) => Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, method);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Radio<PaymentMethod>(
                              value: method,
                              groupValue: selectedMethod,
                              onChanged: (value) {
                                setState(() {
                                  selectedMethod = value!;
                                });
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              method.assetPath,
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              method.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result is PaymentMethod) {
      setState(() {
        selectedMethod = result;
      });
      print(selectedMethod);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin đơn hàng",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ConstantAppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Phương thức thanh toán", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 8),
              Container(
                height: 60,
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: showPayment,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ConstantAppColor.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Builder(
                            builder: (_) {
                              if (selectedMethod == null) {
                                return Icon(
                                  Icons.credit_score_rounded,
                                  color: Colors.blue,
                                );
                              } else {
                                return Image.asset(
                                  "assets/payment/momo.webp",
                                  height: 24,
                                  width: 24,
                                );
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedMethod != null
                                  ? selectedMethod!.title
                                  : "Chọn phương thức",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text("Thông tin thanh toán",style: TextStyle(fontSize: 24)),
              const SizedBox(height: 8),
              _buildInfoCard(),
              const SizedBox(height: 8),
              Text("Thông tin chi tiết",style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              _buildTicketInfo(),
              const SizedBox(height: 10),
              _buildTicketInfo(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints(maxHeight: 130),
        height: 130,
        padding: EdgeInsets.all(30.0),
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth * 0.5, // 90% width of container
              height: constraints.maxHeight * 0.5, // 60% height of container
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ConstantAppColor.primary,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Thanh toán 90.000đ",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTicketInfo() {
    return Column(
      children: [
        TicketBox(
            onTap: (){},
            ticketName: "Vé 1 lượt",
            bottomContent:
            Text(
              overflow: TextOverflow.ellipsis,
              '90.000đ x 2 vé = 180.000đ',
              style: TextStyle(
                fontSize: 17,
                color: ConstantAppColor.primary,
              ),
            )
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ga Bến Thành - Ga Suối Tiên',
                  style: TextStyle(color: Colors.black,fontSize: 18),
                ),
              ),
              _InfoRow(label: 'Loại vé:', value: 'Vé 3 ngày'),
              _InfoRow(label: 'HSD:', value: '72h kể từ thời điểm kích hoạt'),
              SizedBox(height: 8),

            ],
          ),
        )
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all( width: 1,color: Colors.black12)
      ),
      child: Column(
        children: const [
          _InfoRow(label: 'Số lượng:', value: '1'),
          _InfoRow(label: 'Thành tiền:', value: '90.000đ', isBold: true),
          Divider(),
          _InfoRow(label: 'Tổng giá tiền:', value: '90.000đ'),
          _InfoRow(label: 'Thành tiền:', value: '90.000đ', isBold: true),
        ],
      ),
    );
  }

}
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final valueStyle = isBold
        ? const TextStyle(fontWeight: FontWeight.bold)
        : const TextStyle();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),
          Expanded(flex: 3, child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }
}