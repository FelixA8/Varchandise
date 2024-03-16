import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/provider.dart';
import 'package:varchandise/rest/profile_user_api.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();

  String userName = "";
  String userMail = "";
  String userAddress = "";
  SharedPreferences? _sharedPreferences;

  void getUserData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userName = _sharedPreferences!.getString('username').toString();
    userMail = _sharedPreferences!.getString('usermail').toString();
    await getUser(userMail).then((value) {
      setState(() {
        userAddress = value.userAddress;
        if (userAddress != "") {
          return;
        }
      });
    });
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
    void validate() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        await updateProfile(userMail, userName, userAddress);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: themeChange.darkTheme ? Colors.white : Colors.black,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
              color: themeChange.darkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: themeChange.darkTheme ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: GoogleFonts.poppins()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.name,
                        onSaved: (newValue) {},
                        style: GoogleFonts.poppins(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          hintText: userMail,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  Text('Name', style: GoogleFonts.poppins()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        initialValue: userName,
                        keyboardType: TextInputType.name,
                        onSaved: (newValue) {
                          setState(() {
                            userName = newValue!;
                          });
                        },
                        style: GoogleFonts.poppins(),
                        decoration: InputDecoration(
                          hintText: userName,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  Text('ProfileImage', style: GoogleFonts.poppins()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        enabled: false,
                        keyboardType: TextInputType.name,
                        onSaved: (newValue) {},
                        style: GoogleFonts.poppins(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xff7408C2),
                      ),
                      onPressed: () {
                        validate();
                      },
                      child: Text(
                        'Update Form',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
