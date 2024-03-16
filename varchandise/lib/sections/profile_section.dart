import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/provider.dart';
import 'package:varchandise/rest/get_history_api.dart';
import 'package:varchandise/screens/login_screen.dart';
import 'package:varchandise/sections/profile%20sections/about_us.dart';
import 'package:varchandise/sections/profile%20sections/edit_address.dart';
import 'package:varchandise/sections/profile%20sections/edit_profile.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  SharedPreferences? _sharedPreferences;
  String userName = "";
  String userMail = "";

  void logOut() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences!.clear();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
    final _oauth = GoogleSignIn(scopes: ['email']);
    await _oauth.signOut();
  }

  void getUserData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userName = _sharedPreferences!.getString('username').toString();
    userMail = _sharedPreferences!.getString('usermail').toString();
    setState(() {});
  }

  void clearHistory() async {
    await deleteUserHistory(userMail);
  }

  clearHistoryAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 90,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Do you want to clear all the history?",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    height: 0,
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                clearHistory();
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  "Yes",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xff4CAF50)),
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                            width: 0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xffDC0000)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  void goToEditProfileScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileScreen(),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    getUserData();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Profile',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 200,
                height: 5,
                color: const Color(0xff7408C2),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("images/steve_jobs.jpg")),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userMail,
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 135,
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            backgroundColor: const Color(0xff7408C2),
                          ),
                          onPressed: () {
                            goToEditProfileScreen();
                          },
                          child: Text(
                            'Edit Profile',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    backgroundColor: const Color(0xff9C8747),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Gold Member',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                thickness: 1,
              ),
              EditProfileCategories(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditAddressScreen(),
                        ));
                  },
                  description: "",
                  title: "Address",
                  icon: const Icon(FontAwesomeIcons.locationArrow),
                  keyword: "",
                  showArrow: true),
              EditProfileCategories(
                  onTap: () {
                    clearHistoryAlertDialog(context);
                  },
                  description: "",
                  title: "Clear History",
                  icon: const Icon(FontAwesomeIcons.trash),
                  keyword: "",
                  showArrow: true),
              EditProfileCategories(
                  onTap: () {
                    bool value = themeChange.darkTheme;
                    themeChange.darkTheme = !value;
                  },
                  description: "",
                  title: "Change Theme",
                  icon: const Icon(FontAwesomeIcons.yinYang),
                  keyword: "",
                  showArrow: true),
              EditProfileCategories(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsScreen(),
                        ));
                  },
                  description: "",
                  title: "About Us",
                  icon: const Icon(FontAwesomeIcons.info),
                  keyword: "",
                  showArrow: true),
              const Divider(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                thickness: 1,
              ),
              EditProfileCategories(
                  onTap: () {
                    logOut();
                  },
                  description: "",
                  title: "Log Out",
                  icon: const Icon(Icons.exit_to_app),
                  keyword: "",
                  showArrow: false),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileCategories extends StatelessWidget {
  const EditProfileCategories({
    super.key,
    required this.description,
    required this.title,
    required this.icon,
    required this.keyword,
    required this.showArrow,
    required this.onTap,
  });
  final Icon icon;
  final String description;
  final String title;
  final String keyword;
  final bool showArrow;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: icon,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 11,
              child: Text(
                title,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            const Spacer(),
            Expanded(
                flex: 1,
                child: showArrow
                    ? const Icon(
                        FontAwesomeIcons.angleRight,
                        size: 20,
                      )
                    : Container()),
          ],
        ),
      ),
    );
  }
}
