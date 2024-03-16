import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/models/user_models.dart';

//UPDATE PROFILE
Future updateProfile(
    String customerEmail, String userName, String userAddress) async {
  SharedPreferences? _sharedPreferences;
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/update-profile'),
      headers: {
        "Accept": "Application/json"
      },
      body: {
        'customerEmail': customerEmail,
        'name': userName,
        'address': userAddress
      });
  var decodedData = jsonDecode(response.body);
  _sharedPreferences = await SharedPreferences.getInstance();
  await _sharedPreferences.setString('username', userName);
  return decodedData;
}

Future<User> getUser(String customerEmail) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/get-user'),
      headers: {"Accept": "Application/json"},
      body: {'customerEmail': customerEmail});
  var decodedData = jsonDecode(response.body);
  User decoded = User.fromJson(decodedData[0]);
  return decoded;
}
