import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/rest/rest_login_api.dart';
import 'package:varchandise/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen(
      {super.key, required this.newUserAddress, required this.newUserName});
  final String newUserName;
  final String newUserAddress;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPassword = true;
  bool showConfirmedPassword = true;
  final formKey = GlobalKey<FormState>();
  String newUserEmail = '';
  String newUserPassword = '';

  void changePasswordState() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void changeConfirmedPasswordState() {
    setState(() {
      showConfirmedPassword = !showConfirmedPassword;
    });
  }

  void validate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
    await doRegister(widget.newUserName, widget.newUserAddress, newUserEmail,
        newUserPassword);
  }

  doRegister(String name, String address, String email, String password) async {
    var res = await userRegister(name, address, email, password);
    if (res["success"]) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } else if (res["success"] == false) {
      print("ERROR :(");
    }
  }

  void goToLoginScreen() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ > 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset('images/varchandise_logo2.jpg'),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        onSaved: (newValue) {
                          newUserEmail = newValue!;
                        },
                        style:
                            GoogleFonts.poppins(color: const Color(0xff7408C2)),
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        obscureText: showPassword,
                        onSaved: (newValue) {
                          newUserPassword = newValue!;
                        },
                        style:
                            GoogleFonts.poppins(color: const Color(0xff7408C2)),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: changePasswordState,
                                icon: Icon(showPassword
                                    ? Icons.remove_red_eye
                                    : FontAwesomeIcons.eyeSlash)),
                            labelText: 'Password'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        obscureText: showConfirmedPassword,
                        style:
                            GoogleFonts.poppins(color: const Color(0xff7408C2)),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: changeConfirmedPasswordState,
                                icon: Icon(showConfirmedPassword
                                    ? Icons.remove_red_eye
                                    : FontAwesomeIcons.eyeSlash)),
                            labelText: 'Confirm Password'),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff7408C2)),
                        ),
                        onPressed: () {
                          validate();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side: BorderSide(
                                width: 1,
                                color: Color(0xff7408C2),
                              ),
                            ),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffffffff)),
                        ),
                        onPressed: goToLoginScreen,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 65, vertical: 10),
                          child: Text(
                            'Back',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: const Color(0xff7408C2)),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
