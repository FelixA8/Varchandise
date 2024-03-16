import 'package:intl/intl.dart';

class History {
  History(
      {required this.historyID,
      required this.customerEmail,
      required this.productID,
      required this.purchasedAmount,
      required this.totalPrice,
      required this.datePurchased,
      required this.productName,
      required this.productPrice,
      required this.imgURL});
  String historyID;
  String productID;
  String customerEmail;
  int purchasedAmount;
  int totalPrice;
  String datePurchased;
  String productName;
  int productPrice;
  String imgURL;

  String get getFormattedTotalPrice {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(totalPrice);
  }

  String get getFormattedProductPrice {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(productPrice);
  }

  factory History.fromJson(Map<String, dynamic> json) => History(
      historyID: json["HistoryID"].toString(),
      customerEmail: json["CustomerEmail"].toString(),
      productID: json["ProductID"].toString(),
      purchasedAmount: json["PurchasedAmount"] as int,
      totalPrice: json["TotalPrice"] as int,
      datePurchased: json["DatePurchased"].toString(),
      productName: json["ProductName"].toString(),
      productPrice: json["ProductPrice"] as int,
      imgURL: json["ProductImage"].toString());

  String get formatDate {
    DateTime now = DateTime.parse(datePurchased).toLocal();
    var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    var formatted = formatter.format(now);
    return formatted;
  }
}
