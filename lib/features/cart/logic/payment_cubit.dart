// payment_cubit.dart - Updated States and Cubit
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/momo_payment_query.dart';
import '../data/model/payment_result.dart';

abstract class PaymentState {}

class LoadingPayment extends PaymentState {}

class FetchPayment extends PaymentState {
  final PaymentResult paymentResult;
  FetchPayment({required this.paymentResult});
}

class PaymentResultCubit extends Cubit<PaymentState> {
  PaymentResultCubit() : super(LoadingPayment());

  void fetchPaymentResult(PaymentQuery query) async {
    try {
      emit(LoadingPayment());

      await Future.delayed(Duration(seconds: 2));

      PaymentResult result = await _processPaymentQuery(query);

      emit(FetchPayment(paymentResult: result));
    } catch (e) {
      emit(
        FetchPayment(
          paymentResult: PaymentResult(
            isConfirm: false,
            ticketCount: 0,
            message: 'THANH TOÁN THẤT BẠI',
          ),
        ),
      );
    }
  }

  Future<PaymentResult> _processPaymentQuery(PaymentQuery query) async {
    bool isSuccess = query.orderId.contains('success') ?? true;

    if (isSuccess) {
      return PaymentResult(
        isConfirm: true,
        ticketCount: 2, // Mock ticket count
        message: 'THANH TOÁN 2 VÉ THÀNH CÔNG',
      );
    } else {
      return PaymentResult(
        isConfirm: false,
        ticketCount: 0,
        message: 'THANH TOÁN THẤT BẠI',
      );
    }
  }

  void resetPaymentState() {
    emit(LoadingPayment());
  }
}
