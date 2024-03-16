import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:varchandise/models/history_models.dart';

//GET HISTORY
Future<List<History>> getUserHistory(String userEmail) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/AllUserHistory'),
      headers: {"Accept": "Application/json"},
      body: {'customerEmail': userEmail});
  var decodedData = jsonDecode(response.body);
  List<History> list = [];
  for (var i in decodedData) {
    History fetchedData = History.fromJson(i);
    list.add(fetchedData);
  }
  return list;
}

//GET HIGHEST History ID NUMBER
Future getHighestHistoryID() async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.get(
    Uri.parse('$baseUrl/users/getHistoryHighestID'),
    headers: {"Accept": "Application/json"},
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

Future createUserHistory(String userEmail, String productID,
    int purchasedAmount, int productPrice) async {
  String baseUrl = "http://10.0.2.2:3000";
  String id = "";
  var data = await getHighestHistoryID();
  if (data.length == 0) {
    id = 'MH001';
  } else {
    var newID = data[0]["HistoryID"];
    int inputID = extractAndIncrement(newID);
    id = 'MH${inputID.toString().padLeft(3, '0')}';
  }
  final response = await http
      .post(Uri.parse('$baseUrl/users/insert-new-user-history'), headers: {
    "Accept": "Application/json"
  }, body: {
    'historyID': id,
    'productID': productID,
    'historyAmount': purchasedAmount.toString(),
    'totalPrice': (purchasedAmount * productPrice).toString(),
    'customerEmail': userEmail
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future deleteUserHistory(String userEmail) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.delete(
      Uri.parse('$baseUrl/users/delete-user-history'),
      headers: {"Accept": "Application/json"},
      body: {'customerEmail': userEmail});
  return response;
}
