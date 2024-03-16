import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/sections/home_section.dart';
import 'package:varchandise/sections/profile_section.dart';
import 'package:varchandise/sections/history_section.dart';
import 'package:varchandise/sections/shopping_cart_section.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int currentSectionIndex = 0;
  SharedPreferences? _sharedPreferences;
  String userName = "";
  String userMail = "";
  Widget? currentScreen;
  Color homeButtonColor = const Color(0xff7408C2);
  Color cartButtonColor = const Color(0xff8A8A8A);
  Color historyButtonColor = const Color(0xff8A8A8A);
  Color accountButtonColor = const Color(0xff8A8A8A);

  void changeCurrentIndex() {
    setState(() {
      if (currentSectionIndex == 0) {
        currentScreen = const HomeSection();
        homeButtonColor = const Color(0xff7408C2);
        cartButtonColor = const Color(0xff8A8A8A);
        historyButtonColor = const Color(0xff8A8A8A);
        accountButtonColor = const Color(0xff8A8A8A);
      } else if (currentSectionIndex == 1) {
        currentScreen = const ShoppingCartSection();
        homeButtonColor = const Color(0xff8A8A8A);
        cartButtonColor = const Color(0xff7408C2);
        historyButtonColor = const Color(0xff8A8A8A);
        accountButtonColor = const Color(0xff8A8A8A);
      } else if (currentSectionIndex == 2) {
        currentScreen = const HistorySection();
        homeButtonColor = const Color(0xff8A8A8A);
        cartButtonColor = const Color(0xff8A8A8A);
        historyButtonColor = const Color(0xff7408C2);
        accountButtonColor = const Color(0xff8A8A8A);
      } else if (currentSectionIndex == 3) {
        currentScreen = ProfileSection();
        homeButtonColor = const Color(0xff8A8A8A);
        cartButtonColor = const Color(0xff8A8A8A);
        historyButtonColor = const Color(0xff8A8A8A);
        accountButtonColor = const Color(0xff7408C2);
      }
    });
  }

  void getUserData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userName = _sharedPreferences!.getString('username').toString();
    userMail = _sharedPreferences!.getString('usermail').toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    changeCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        height: 55,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                currentSectionIndex = 0;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.home,
                size: 28,
                color: homeButtonColor,
              ),
            ),
            IconButton(
              onPressed: () {
                currentSectionIndex = 1;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.shoppingCart,
                size: 26,
                color: cartButtonColor,
              ),
            ),
            IconButton(
              onPressed: () {
                currentSectionIndex = 2;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.clock,
                size: 28,
                color: historyButtonColor,
              ),
            ),
            IconButton(
              onPressed: () {
                currentSectionIndex = 3;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.user,
                size: 28,
                color: accountButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
