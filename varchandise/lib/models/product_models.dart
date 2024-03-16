import 'package:intl/intl.dart';
import 'package:varchandise/models/cart_models.dart';

class Product {
  Product(
      {required this.productCategory,
      required this.productDescription,
      required this.productID,
      required this.productImageURL,
      required this.productName,
      required this.productPrice,
      required this.productSeller,
      required this.productStock});
  String productID;
  String productName;
  String productDescription;
  Category productCategory;
  int productStock;
  String productImageURL;
  String productSeller;
  int productPrice;

  String get getFormattedPrice {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(productPrice);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    String categJsonOutput = json["ProductCategory"].toString();
    Category? category;

    if (categJsonOutput == 'anime') {
      category = Category.anime;
    } else if (categJsonOutput == 'disney') {
      category = Category.disney;
    } else if (categJsonOutput == 'superhero') {
      category = Category.superhero;
    } else {
      category = Category.none;
    }
    return Product(
      productID: json["ProductID"].toString(),
      productName: json["ProductName"].toString(),
      productDescription: json["ProductDescription"].toString(),
      productCategory: category,
      productStock: json["ProductStock"] as int,
      productImageURL: json["ProductImage"].toString(),
      productSeller: json["ProductSeller"].toString(),
      productPrice: json["ProductPrice"] as int,
    );
  }
}
