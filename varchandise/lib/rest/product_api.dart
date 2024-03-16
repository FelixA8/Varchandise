import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:varchandise/models/product_models.dart';

//GET ALL PRODUCT
Future<List<Product>> getProduct(String productID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(Uri.parse('$baseUrl/users/get-all-product'),
      headers: {"Accept": "Application/json"});
  var decodedData = jsonDecode(response.body);
  List<Product> list = [];
  for (var i in decodedData) {
    Product fetchedData = Product.fromJson(i);
    list.add(fetchedData);
  }
  return list;
}

//GET SPECIFIC PRODUCT
Future getSpecificProduct(String productID) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(
      Uri.parse('$baseUrl/users/get-product?id=$productID'),
      headers: {"Accept": "Application/json"});
  var decodedData = jsonDecode(response.body);
  List<Product> list = [];
  for (var i in decodedData) {
    Product fetchedData = Product.fromJson(i);
    list.add(fetchedData);
  }
  return decodedData;
}

DateTime decomposeDate(String date) {
  var newDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(date);
  return newDate;
}
