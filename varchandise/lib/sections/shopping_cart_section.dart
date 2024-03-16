import 'package:flutter/material.dart';
import 'package:varchandise/widgets/cart_listview.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCartSection extends StatefulWidget {
  const ShoppingCartSection({super.key});

  @override
  State<ShoppingCartSection> createState() => _ShoppingCartSectionState();
}

class _ShoppingCartSectionState extends State<ShoppingCartSection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Cart',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: 200,
              height: 5,
              color: const Color(0xff7408C2),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Expanded(child: CartListView()),
        ],
      ),
    );
  }
}
