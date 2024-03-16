import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:varchandise/provider.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
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
          "About Us",
          style: GoogleFonts.poppins(
              color: themeChange.darkTheme ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: themeChange.darkTheme ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/varchandise_logo.png'),
              Text(
                'Welcome to our online shop, your ultimate destination for all things character figures! We\'re more than just a store; w\'re a community of enthusiasts who share a profound love for collectible characters and the stories they represent. Here\'s a glimpse into what makes our application truly special:',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Our Passion for Characters: ',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                'At our core, we\'re driven by a deep passion for the intricate and fascinating world of character figures. We understand that these figures are more than just collectibles; they\'re cherished emblems of the stories and characters that have touched our lives in unforgettable ways. The Widest Selection: Our virtual shelves are stocked with an expansive collection of character figures from a multitude of universes. Whether you\'re a fan of superheroes, anime icons, movie legends, or pop culture sensations, you\'ll find your favorite characters here.',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Quality and Authenticity: ',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                'We take pride in the authenticity and quality of our products. Each figure is carefully selected, ensuring it meets our standards for craftsmanship and detail. Rest assured, you\'re investing in genuine pieces of art.',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Community-Centric: ',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                'We\'re more than just a store; we\'re a gathering place for character figure enthusiasts. Connect with fellow fans, share your collections, and engage in discussions about the latest releases and the classics that continue to captivate us.',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Unforgettable Shopping Experience: ',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                'Our application is designed to make your shopping journey seamless and enjoyable. With user-friendly navigation and an intuitive interface, finding your favorite characters is a breeze.',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Exclusive Releases and Promotions:  ',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                'Stay tuned for exclusive releases and promotions that you won\'t find anywhere else. We\'re committed to offering our community unique opportunities to enrich their collections.',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Dedicated Support:   ',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                'Our customer support team is here to assist you at every step. Have a question, concern, or need guidance on your next purchase? We\'re just a message away.',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Secure Shopping: ',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                'We take your security seriously. Shop with peace of mind, knowing that your personal information is safeguarded, and your transactions are protected.',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
