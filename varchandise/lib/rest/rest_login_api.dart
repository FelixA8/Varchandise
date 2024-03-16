import 'dart:convert';

import 'package:http/http.dart' as http;

//CHECK GOOGLE SIGN IN
Future checkGoogleLogin(String email) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/hasGoogleLogin'),
      headers: {"Accept": "Application/json"}, body: {'email': email});
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

//LOGIN USER
Future userLogin(String email, String password) async {
  String baseUrl = "http://10.0.2.2:3000";
  final response = await http.post(Uri.parse('$baseUrl/users/login'),
      headers: {"Accept": "Application/json"},
      body: {'email': email, 'password': password});
  var decodedData = jsonDecode(response.body);

  return decodedData;
}

//REGISTER USER
Future userRegister(
    String username, String address, String email, String password) async {
  String baseUrl = "http://10.0.2.2:3000";
  //LAST CHECKPOINT
  final response = await http.post(Uri.parse('$baseUrl/users/register'), body: {
    'name': username,
    'email': email,
    'password': password,
    'address': address
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}
