import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:varchandise/models/product_models.dart';

//LOGIN ADMIN
Future adminLogin(String email, String password) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/admin/login'),
      headers: {"Accept": "Application/json"},
      body: {'email': email, 'password': password});
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

//GET ALL PRODUCT ADMIN
Future<List<Product>> getAllAdminProduct(String token) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(
    Uri.parse('$baseUrl/admin/'),
    headers: {
      "Accept": "Application/json",
      "Authorization": "Bearer $token",
    },
  );
  var decodedData = jsonDecode(response.body);

  List<Product> list = [];
  for (var i in decodedData) {
    Product fetchedData = Product.fromJson(i);
    list.add(fetchedData);
  }
  return list;
}

//GET HIGHEST Product ID NUMBER
Future getHighestProductID(String token) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(
    Uri.parse('$baseUrl/admin/getProductHighestID'),
    headers: {"Accept": "Application/json", "Authorization": "Bearer $token"},
  );
  var decodedData = jsonDecode(response.body.toString());
  return decodedData;
}

//Extract History ID NUMBER
int extractAndIncrement(String input) {
  RegExp regex = RegExp(r'\d+');
  Match match = regex.firstMatch(input) as Match;
  String? numbersOnly = match.group(0);

  int currentNumber = int.parse(numbersOnly!);
  int incrementedNumber = currentNumber + 1;

  return incrementedNumber;
}

//GET SPECIFIC PRODUCT ADMIN
Future<Product> getSpecificAdminProduct(String token, String productID) async {
  String baseUrl = "http://10.0.2.2:3000";

  final response =
      await http.post(Uri.parse('$baseUrl/admin/get-product'), headers: {
    "Accept": "Application/json",
    "Authorization": "Bearer $token",
  }, body: {
    "id": productID,
  });

  var decodedData = jsonDecode(response.body);
  Product product = Product.fromJson(decodedData[0]);
  return product;
}

//INSERT SPECIFIC PRODUCT ADMIN
Future insertSpecificAdminProduct(
    String token,
    String name,
    String category,
    String price,
    String seller,
    String stock,
    String description,
    String imageURL) async {
  String id = '';
  String baseUrl = "http://10.0.2.2:3000";
  var data = await getHighestProductID(token);
  if (data.length == 0) {
    id = 'PR001';
  } else {
    var newID = data[0]["ProductID"];
    int inputID = extractAndIncrement(newID);
    id = 'PR${inputID.toString().padLeft(3, '0')}';
  }
  final response =
      await http.post(Uri.parse('$baseUrl/admin/insert-new-product'), headers: {
    "Accept": "Application/json",
    "Authorization": "Bearer $token",
  }, body: {
    "id": id,
    "name": name,
    "description": description,
    "category": category,
    "stock": stock,
    "image": imageURL,
    "price": price,
    "seller": seller
  });

  var decodedData = response.statusCode;
  return decodedData;
}

//UPDATE SPECIFIC PRODUCT ADMIN
Future updateSpecificAdminProduct(
    String token,
    String id,
    String name,
    String category,
    String price,
    String seller,
    String stock,
    String description,
    String imageURL) async {
  String baseUrl = "http://10.0.2.2:3000";
  print(description);
  final response =
      await http.post(Uri.parse('$baseUrl/admin/update-product'), headers: {
    "Accept": "Application/json",
    "Authorization": "Bearer $token",
  }, body: {
    "id": id,
    "name": name,
    "description": description,
    "category": category,
    "stock": stock,
    "image": imageURL,
    "price": price,
    "seller": seller
  });

  var decodedData = response.statusCode;
  return decodedData;
}

//DELETE USER PRODUCT
Future deleteSpecificAdminProduct(String token, String id) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response =
      await http.delete(Uri.parse('$baseUrl/admin/delete-product'), headers: {
    "Accept": "Application/json",
    "Authorization": "Bearer $token",
  }, body: {
    "id": id,
  });
  var decodedData = response.body;
  return decodedData;
}
