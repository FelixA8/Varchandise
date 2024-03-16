import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/admin-components/admin-screens/admin_insert_screen.dart';
import 'package:varchandise/admin-components/admin-screens/admin_stock_product_screen.dart';
import 'package:varchandise/screens/login_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset('images/varchandise_logo.png'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    elevation: const MaterialStatePropertyAll(10),
                    shadowColor:
                        const MaterialStatePropertyAll(Color(0xff7408C2))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminStockProductScreen(),
                      ));
                },
                child: Text(
                  'Current Stock and Products',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    elevation: const MaterialStatePropertyAll(10),
                    shadowColor:
                        const MaterialStatePropertyAll(Color(0xff7408C2))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminInsertScreen(),
                    ),
                  );
                },
                child: Text(
                  'Insert New Products',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xff7408C2)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  elevation: const MaterialStatePropertyAll(10),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                          settings: const RouteSettings(name: "/")));
                },
                child: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
