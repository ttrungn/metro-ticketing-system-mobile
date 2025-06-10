

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils{
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,{
    required String title,
    String okBtnText="OK",
    String cancelBtnText="Cancel",
    required VoidCallback okBtnFunction,
    double? contentWidth,
    double? contentHeight,
  }){
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          // Đặt backgroundColor là transparent để ClipPath và Material bên trong kiểm soát hình dạng và màu
          backgroundColor: Colors.transparent,
          // Đảm bảo không có padding mặc định từ Dialog
          insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0), // Khoảng cách với mép màn hình

          child: ClipPath( // <--- ClipPath bao bọc toàn bộ nội dung của Dialog
            clipper: CustomTicketShape(),
            child: Material( // <--- Material để cung cấp màu nền và bóng đổ cho hình dạng vé
              color: Colors.white, // Màu nền của toàn bộ Dialog có hình dạng vé
              elevation: 5.0, // Độ nổi cho Dialog
              child: IntrinsicWidth( // Giúp Dialog tự điều chỉnh chiều rộng theo nội dung (hoặc theo width của SizedBox)
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Giúp Column chỉ chiếm không gian cần thiết
                  children: [
                    // Title Section
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall, // Sử dụng style mặc định của AlertDialog title
                        textAlign: TextAlign.center, // Canh giữa title nếu muốn
                      ),
                    ),

                    // Content Section
                    SizedBox(
                      width: contentWidth ?? MediaQuery.of(context).size.width * 0.7,
                      height: contentHeight ?? 100,
                      child: Center(
                        child: Text("hehe"),
                      ),
                    ),

                    // Actions Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: okBtnFunction,
                            child: Text(okBtnText),
                          ),
                          TextButton(
                            child: Text(cancelBtnText),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class CustomTicketShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(8)));
    path.addOval(
        Rect.fromCircle(
            center: Offset(0, size.height*0.85),
            radius: 15));
    path.addOval(
        Rect.fromCircle(
            center: Offset(size.width, size.height * 0.85),
            radius: 15));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}