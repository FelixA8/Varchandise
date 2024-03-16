import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/admin-components/admin-rest-api/admin_login.dart';
import 'package:varchandise/admin-components/admin-screens/admin_home_screen.dart';
import 'package:varchandise/admin-components/admin_bearertoken.dart' as bt;
import 'package:varchandise/rest/rest_login_api.dart';
import 'package:varchandise/screens/navigation_screen.dart';
import 'package:varchandise/screens/register_data_screen.dart';
import 'package:varchandise/screens/splash_screen/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool rememberBool = false;
  SharedPreferences? _sharedPreferences;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isauthenticating = false;
  //GOOGLE SIGN IN
  final _oauth = GoogleSignIn(scopes: ['email']);

  void signInGoogle() async {
    final GoogleSignInAccount? account = await _oauth.signIn();
    _sharedPreferences = await SharedPreferences.getInstance();
    if (account != null) {
      var hasLoggedIn = await userLogin(account.email, "");
      if (!hasLoggedIn["success"]) {
        //VALIDATE GOOGLE SIGN IN. IF USER HAS EVER SIGN IN WITH GOOGLE, PROCEED TO HOME PAGE.
        //IF NOT, PROCEED TO REGISTER NAME, ADDRESS PAGE.
        var res = await checkGoogleLogin(account.email);
        if (res["success"]) {
          var userEmail = account.email;
          String userName = account.displayName.toString();
          _sharedPreferences!.setString('usermail', userEmail);
          _sharedPreferences!.setString('username', userName);
          changeScreenToHomeScreen();
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterDataScreen(
                    googleSignIn: true, googleEmail: account.email),
              ));
        }
      } else {
        showAlertDialog(context);
      }
    }
  }

  void changeScreenToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
      ),
    );
  }

  //VALIDATE EMAIL AND PASSWORD INPUTTED. IF SUCCESS, THEN DO USER LOGIN
  void userValidate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await loginUser(_enteredEmail, _enteredPassword);
    }
  }

  //ADMIN LOGIN
  void adminValidate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await loginAdmin(_enteredEmail, _enteredPassword);
    }
  }

  //GO TO REGISTER SCREEN
  void changeToSignInScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const RegisterDataScreen(
          googleSignIn: false,
          googleEmail: "",
        );
      },
    ));
  }

  //ADMIN LOGIN
  loginAdmin(email, password) async {
    setState(() {
      _isauthenticating = true;
    });
    var res = await adminLogin(email, password);
    if (res["success"]) {
      bt.bearerToken = res["message"];
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHomeScreen(),
          ));
    } else {
      setState(() {
        _isauthenticating = false;
      });
      //ERROR
      // ignore: use_build_context_synchronously
      showAlertDialog(context);
    }
  }

  //USER LOGIN
  loginUser(String email, String password) async {
    setState(() {
      _isauthenticating = true;
    });
    _sharedPreferences = await SharedPreferences.getInstance();
    var res = await userLogin(email.trim(), password.trim());
    if (res["success"]) {
      var userEmail = res['user'][0]['CustomerEmail'];
      String userName = res['user'][0]['CustomerName'].toString();
      _sharedPreferences!.setString('usermail', userEmail);
      _sharedPreferences!.setString('password', password);
      _sharedPreferences!.setString('username', userName);

      changeScreenToHomeScreen();
    } else if (res["success"] == false) {
      setState(() {
        _isauthenticating = false;
      });
      // ignore: use_build_context_synchronously
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    'Wrong email or password, please try again',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    const loginformtextdecoration = InputDecoration(
      labelText: 'email',
      contentPadding: EdgeInsets.only(top: 10, left: 8),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Color(0xff7408C2)),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );

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
                                keyboardType: TextInputType.name,
                                onSaved: (newValue) {
                                  _enteredEmail = newValue!;
                                },
                                decoration: loginformtextdecoration,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xff7408C2)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.name,
                                  obscureText: true,
                                  onSaved: (newValue) {
                                    _enteredPassword = newValue!;
                                  },
                                  decoration: loginformtextdecoration.copyWith(
                                      labelText: 'password'))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                activeColor: const Color(0xff7408C2),
                                value: rememberBool,
                                onChanged: (value) {
                                  setState(() {
                                    rememberBool = !rememberBool;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Remember me',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff8A8A8A), fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (_isauthenticating) const CircularProgressIndicator(),
                      if (!_isauthenticating)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 44),
                          child: SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                backgroundColor: const Color(0xff7408C2),
                              ),
                              onPressed: userValidate,
                              child: Text(
                                'Log In as User',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: const Color(0xff7408C2),
                            ),
                            onPressed: adminValidate,
                            child: Text(
                              'Log In as Admin',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  'Or login using?',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        return signInGoogle();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('images/google.jpg'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('images/facebook.jpg'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        changeToSignInScreen();
                      },
                      child: Text(
                        'Sign up here!!',
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
