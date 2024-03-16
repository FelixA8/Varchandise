class User {
  User(
      {required this.email,
      required this.password,
      required this.username,
      required this.userAddress});
  String username;
  String email;
  String password;
  String userAddress;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["CustomerEmail"].toString(),
      username: json["CustomerName"].toString(),
      password: json["CustomerPassword"].toString(),
      userAddress: json["CustomerAddress"].toString(),
    );
  }
}
