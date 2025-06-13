

import 'package:flutter/material.dart';

import '../../../../core/common/presentation/modals/dialog_utils.dart';
import '../../../../core/common/presentation/widgets/ticket_widgets/ticket_box.dart';
import '../../../../core/constants/app_color.dart';

class BuyTicketBody extends StatelessWidget {
  const BuyTicketBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ConstantAppColor.primaryLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text('📢 Mại dô 🎉 Mua vé đi bà con ơi💰',style: TextStyle(
                    fontSize: 22,color: ConstantAppColor.primary,fontWeight: FontWeight.w600,
                  ),),
                ),
                TicketBox(
                  ticketName: 'Vé 1 chiều',
                  bottomContent: Text(
                    'Vui lòng ấn vào để chọn tuyến!',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ), onTap: () {
                  DialogUtils.showCustomDialog(context, title: "Gallary", okBtnFunction: (){
                    Navigator.of(context).pop();
                  },contentHeight: 300,contentWidth: 500);
                },
                ),
                TicketBox(
                  ticketName: 'Vé 1 ngày',
                  bottomContent: Text(
                    '40.000 đ',
                    style: TextStyle(
                      fontSize: 17,
                      color: ConstantAppColor.primary,
                    ),
                  ), onTap: () {  },
                ),
                TicketBox(
                  ticketName: 'Vé 3 ngày',
                  bottomContent: Text(
                    '90.000 đ',
                    style: TextStyle(
                      fontSize: 17,
                      color: ConstantAppColor.primary,
                    ),
                  ), onTap: () {  },
                ),
                TicketBox(
                  ticketName: 'Vé tháng',
                  bottomContent: Text(
                    '300.000 đ',
                    style: TextStyle(
                      fontSize: 17,
                      color: ConstantAppColor.primary,
                    ),
                  ), onTap: () {  },
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text('Vé học sinh nà bà con💰',style: TextStyle(
                    fontSize: 22,color: ConstantAppColor.primary,fontWeight: FontWeight.w600,
                  ),),
                ),
                TicketBox(
                  ticketName: 'Vé tháng HSSV',
                  bottomContent: Text(
                    '300.000 đ',
                    style: TextStyle(
                      fontSize: 17,
                      color: ConstantAppColor.primary,
                    ),
                  ), onTap: () {  },
                ),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
