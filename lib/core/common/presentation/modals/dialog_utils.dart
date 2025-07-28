import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

import '../../../../features/buy_ticket/presentation/widgets/ticket_dialog_content.dart';
import 'custom_ticket_shape.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
    BuildContext context, {
    required Widget Function() childBuilder,
    required Widget bottomPart,
    double? contentWidth,
    double? contentHeight,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,

      barrierLabel: "Dismiss",
      pageBuilder: (_, __, ___) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24.0,
            ),
            child: ClipPath(
              clipper: CustomTicketShape(),
              child: Material(
                color: ConstantAppColor.primaryLight,
                elevation: 5.0,
                child: IntrinsicWidth(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: SizedBox(
                            width:
                                contentWidth ??
                                MediaQuery.of(context).size.width * 0.15,
                            height:
                                contentWidth ??
                                MediaQuery.of(context).size.width * 0.15,
                            child: Image.asset(
                              'assets/icon/sm_metro_logo_nobg.png',
                            ),
                          ),
                        ),

                        childBuilder(),

                        // <-- DYNAMIC BODY CONTENT
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Expanded(child: bottomPart)],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static VoidCallback buildAndShowBuyTicketDialogAction({
    required BuildContext context,
    required List<Map<String, dynamic>> ticketDetails,
    Widget? bottomPart,
  }) {
    return () {
      showCustomDialog(
        context,
        childBuilder: () => TicketDialogContent(ticketDetails: ticketDetails),
        bottomPart: bottomPart!,
      );
    };
  }
}
