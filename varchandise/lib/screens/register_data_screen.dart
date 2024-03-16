import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/rest/rest_login_api.dart';
import 'package:varchandise/screens/navigation_screen.dart';
import 'package:varchandise/screens/register_screen.dart';

class RegisterDataScreen extends StatefulWidget {
  const RegisterDataScreen(
      {super.key, required this.googleSignIn, required this.googleEmail});
  final bool googleSignIn;
  final String googleEmail;

  @override
  State<RegisterDataScreen> createState() => _RegisterDataScreenState();
}

class _RegisterDataScreenState extends State<RegisterDataScreen> {
  final formKey = GlobalKey<FormState>();
  String newUserName = '';
  String newUserAddress = '';
  String newUserEmail = '';
  String newUserPassword = '';

  void goToRegisterDataScreen() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return RegisterScreen(
            newUserAddress: newUserAddress,
            newUserName: newUserName,
          );
        },
      ));
    }
  }

  void signInGoogle() async {
    if (formKey.currentState!.validate()) {
      var _sharedPreferences = await SharedPreferences.getInstance();
      formKey.currentState!.save();
      await userRegister(newUserName, newUserAddress, widget.googleEmail, "");
      _sharedPreferences.setString('usermail', widget.googleEmail);
      _sharedPreferences.setString('username', newUserName);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigatorScreen(),
          ));
    }
  }

  void backToLoginScreen() {
    Navigator.pop(context);
  }

  void validate() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7408C2),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 359,
                  height: 577,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      ),
                      color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 88,
                      ),
                      Image.asset('images/varchandise_logo.png'),
                      const SizedBox(
                        height: 58,
                      ),
                      Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  onSaved: (newValue) {
                                    newUserName = newValue!;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      labelText: 'Full Name'),
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff7408C2)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  onSaved: (newValue) {
                                    newUserAddress = newValue!;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      labelText: 'Address'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xff7408C2)),
                                  ),
                                  onPressed: () {
                                    if (widget.googleSignIn == false) {
                                      goToRegisterDataScreen();
                                    } else {
                                      signInGoogle();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 65, vertical: 10),
                                    child: Text(
                                      widget.googleSignIn
                                          ? 'Sign In to Google'
                                          : 'Next',
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        backToLoginScreen();
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          color: const Color(0xffFFC107),
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
