import 'package:intl/intl.dart';

enum Category {
  anime,
  disney,
  superhero,
  none,
}

class Cart {
  Cart(
      {required this.cartID,
      required this.imgURL,
      required this.productTitle,
      required this.category,
      required this.price,
      required this.isSelected,
      required this.cartAmount,
      required this.customerEmail,
      required this.productID,
      required this.productStock,
      required this.totalPrice});
  int cartAmount;
  bool isSelected;
  String imgURL;
  String productTitle;
  Category category;
  int price;
  String cartID;
  String productID;
  String customerEmail;
  int totalPrice;
  int productStock;

  String get getFormattedProductPrice {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(price);
  }

  String get getFormattedTotalPrice {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(totalPrice);
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    String categJsonOutput = json["ProductCategory"].toString();
    Category? category;
    String isSelectedJsonOutput = json["isSelected"].toString();
    bool isSelected = false;

    if (isSelectedJsonOutput == 'true') {
      isSelected = true;
    } else {
      isSelected = false;
    }

    if (categJsonOutput == 'anime') {
      category = Category.anime;
    } else if (categJsonOutput == 'disney') {
      category = Category.disney;
    } else if (categJsonOutput == 'superhero') {
      category = Category.superhero;
    } else {
      category = Category.none;
    }

    return Cart(
        cartID: json["CartID"].toString(),
        customerEmail: json["CustomerEmail"].toString(),
        productID: json["ProductID"].toString(),
        cartAmount: json["CartAmount"] as int,
        category: category,
        isSelected: isSelected,
        productTitle: json["ProductName"].toString(),
        price: json["ProductPrice"] as int,
        imgURL: json["ProductImage"].toString(),
        totalPrice: json["TotalPrice"] as int,
        productStock: json["ProductStock"] as int);
  }
}
