import 'package:flutter/material.dart';
import 'custom_ticket_shape.dart';
import 'dashed_line_painter.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

class TicketDialogShell extends StatelessWidget {
  final String okBtnText;
  final String cancelBtnText;
  final VoidCallback okBtnFunction;
  final Widget Function() childBuilder;
  final Widget? footer;
  final double? contentWidth;
  final double? contentHeight;

  const TicketDialogShell({
    super.key,
    required this.okBtnFunction,
    required this.childBuilder,
    this.okBtnText = 'OK',
    this.cancelBtnText = 'Cancel',
    this.footer,
    this.contentWidth,
    this.contentHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: ClipPath(
        clipper: CustomTicketShape(),
        child: Material(
          color: ConstantAppColor.primaryLight,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: SizedBox(
                    width: contentWidth ?? MediaQuery.of(context).size.width * 0.15,
                    height: contentWidth ?? MediaQuery.of(context).size.width * 0.15,
                    child: Image.asset('assets/icon/sm_metro_logo_nobg.png'),
                  ),
                ),

                // Body
                childBuilder(),

                // Dashed Line
                SizedBox(
                  width: double.infinity,
                  height: 10,
                  child: CustomPaint(
                    painter: DashedLinePainter(),
                  ),
                ),

                // Footer
                if (footer != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: footer,
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: okBtnFunction, child: Text(okBtnText)),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(cancelBtnText),
                        ),
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
}
