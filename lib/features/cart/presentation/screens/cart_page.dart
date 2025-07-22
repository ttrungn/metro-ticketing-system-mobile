import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/model/payment_model.dart';
import '../widget/cart_ticket_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/cart/logic/cart_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/cart/data/model/cart_info.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, TextEditingController> quantityControllers = {};
  PaymentMethod? selectedMethod;
  final currencyFormatter = NumberFormat('#,###', 'vi_VN');

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
      body: BlocProvider<CartCubit>(
        create: (_) => CartCubit()..loadCart(),
        child: Builder(
          builder: (context) => _buildContent(context), // Tách logic ra
        ),
      ),
    );
  }


  Widget _buildContent(BuildContext context) {
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

              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Column(
                      children: state.items
                          .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildTicketInfo(context, item),
                      ))
                          .toList(),
                    );
                  } else if (state is CartLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: Text("Không có dữ liệu"));
                  }
                },
              ),
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
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  double total = 0;
                  List<CartInfo> cartItems = [];
                  if (state is CartLoaded) {
                    total = state.totalPrice;
                    cartItems = state.items;
                  }

                  return TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(selectedMethod != null?ConstantAppColor.primary : Colors.grey),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    onPressed: selectedMethod != null? (){
                    context.read<CartCubit>().startPayment(total, cartItems);
                  }: null,
                    child: Text(
                      "Thanh toán ${currencyFormatter.format(total)}đ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTicketInfo(BuildContext context, CartInfo item) {

    if (!quantityControllers.containsKey(item.id)) {
      quantityControllers[item.id] =
          TextEditingController(text: item.quantity.toString());
    }

    final controller = quantityControllers[item.id]!;

    return Column(
      children: [
        CartTicketBox(
          onTap: () {},
          onRemove: () async {
            final shouldRemove = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Xác nhận xoá vé"),
                content: Text("Bạn có chắc chắn muốn xoá vé này khỏi giỏ hàng không?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("Không"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Có"),
                  ),
                ],
              ),
            );

            if (shouldRemove == true) {
              quantityControllers.remove(item.id);
              context.read<CartCubit>().removeItem(item.id);
            }
          },
          ticketName: item.ticketName,
          bottomContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${currencyFormatter.format(item.price)}đ',
                style: TextStyle(fontSize: 18, color: ConstantAppColor.primary),
              ),
              Container(
                height: 33,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // Button -
                    InkWell(
                      onTap: item.quantity > 1 ? () {
                        context.read<CartCubit>().decreaseQuantity(item);
                      } : null,
                      child: Container(
                        width: 26,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: item.quantity > 1 ? Colors.black54 : Colors.grey,
                        ),
                      ),
                    ),
                    // Text field quantity
                    Container(
                      width: 33,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          vertical: BorderSide(color: Colors.black12),
                        ),
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    // Button +
                    InkWell(
                      onTap: () {
                        context.read<CartCubit>().increaseQuantity(item);
                      },
                      child: Container(
                        width: 26,
                        alignment: Alignment.center,
                        child: Icon(Icons.add, size: 20, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.routeName.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    item.routeName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  (item.entryStationName.trim().isNotEmpty || item.exitStationName.trim().isNotEmpty)
                      ? 'Ga ${item.entryStationName} - Ga ${item.exitStationName}'
                      : 'Vé Có Thể Sử Dụng Tại Bất Kỳ Ga Nào!',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              SizedBox(height: 8),
              Align(

                alignment: Alignment.center,
              child: Text("Chúc quý khách có một chuyến đi vui vẻ!",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14)),
              ),
            ],
          ),
        )
      ],
    );
  }


  Widget _buildInfoCard() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final totalQuantity = state.items.fold<int>(0, (sum, item) => sum + item.quantity);
          final totalPrice = state.totalPrice;

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: Colors.black12),
            ),
            child: Column(
              children: [
                _InfoRow(label: 'Số lượng:', value: '$totalQuantity vé'),
                _InfoRow(label: 'Tạm tính:', value: '${currencyFormatter.format(totalPrice)}đ'),
                Divider(),
                _InfoRow(label: 'Tổng giá tiền:', value: '${currencyFormatter.format(totalPrice)}đ'),
                _InfoRow(label: 'Thành tiền:', value: '${currencyFormatter.format(totalPrice)}đ', isBold: true),
              ],
            ),
          );
        } else {
          return Center(child: Text("Không thể tải thông tin giỏ hàng"));
        }
      },
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