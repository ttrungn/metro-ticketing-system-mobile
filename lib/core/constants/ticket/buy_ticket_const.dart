



import 'package:intl/intl.dart';

class ConstantBuyTicket {
  static const String buyTitle = "🎉 Mua vé đi bà con ơi💰";
  static const String studentTicketTitle = "Vé học sinh nà bà con💰";

  static const String oneWayTicketBottomText = "Vui lòng ấn vào để chọn tuyến!";
  static const String searchRouteTicket = "Bà con chọn tuyến ii";
}


class ConstantTicketDialog{
  static const double buyHeight = 0.2;
  static const double buyWidth = 0.85;

  static const double infoHeight = 0.35;
}

var currencyFormatter = NumberFormat.currency(locale:'vi_VN',symbol:'',decimalDigits:0);


const MOMO_PAYMENT_API = "";

