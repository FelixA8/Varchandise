import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/admin-components/admin-rest-api/admin_login.dart';
import 'package:varchandise/admin-components/admin-screens/admin_home_screen.dart';
import 'package:varchandise/admin-components/admin_bearertoken.dart' as bt;
import 'package:varchandise/models/product_models.dart';

class AdminUpdateProductScreen extends StatefulWidget {
  const AdminUpdateProductScreen({super.key, required this.productID});
  final String productID;

  @override
  State<AdminUpdateProductScreen> createState() =>
      _AdminUpdateProductScreenState();
}

class _AdminUpdateProductScreenState extends State<AdminUpdateProductScreen> {
  var _enteredProductName = '';
  var _enteredProductCategory = '';
  var _enteredProductPrice = '';
  var _enteredProductSeller = '';
  var _enteredProductStock = '';
  var _enteredProductDescription = '';
  var _enteredProductImageURL = '';

  var currencies = ["anime", "disney", "superhero", "none"];

  final formKey = GlobalKey<FormState>();
  Future getSpecificProduct() async {
    Future<Product> product =
        getSpecificAdminProduct(bt.bearerToken, widget.productID);
    return product;
  }

  void updateForm(id) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(_enteredProductDescription);
      updateSpecificAdminProduct(
          bt.bearerToken,
          id,
          _enteredProductName,
          _enteredProductCategory,
          _enteredProductPrice,
          _enteredProductSeller,
          _enteredProductStock,
          _enteredProductDescription,
          _enteredProductImageURL);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AdminHomeScreen(),
              settings: const RouteSettings(name: "/home")));
    }
  }

  @override
  Widget build(BuildContext context) {
    const textDecoration = InputDecoration(
      labelText: '',
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Color(0xff7408C2)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Update Stock and Products',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
            future: getSpecificProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Product product = snapshot.data as Product;
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PRODUCT ID',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: TextFormField(
                            readOnly: true,
                            initialValue: product.productID,
                            keyboardType: TextInputType.name,
                            decoration: textDecoration,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Text(
                          'PRODUCT NAME',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredProductName = newValue!;
                            },
                            initialValue: product.productName,
                            keyboardType: TextInputType.name,
                            decoration: textDecoration,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Text(
                          'PRODUCT CATEGORY',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: DropdownButtonFormField(
                            decoration: textDecoration,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                            isExpanded: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "can't empty";
                              } else {
                                return null;
                              }
                            },
                            value: product.productCategory.name,
                            items: currencies.map((String val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _enteredProductCategory = value!;
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                _enteredProductCategory = value!;
                              });
                            },
                          ),
                        ),
                        Text(
                          'PRODUCT PRICE',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some values';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredProductPrice = newValue!;
                            },
                            initialValue: product.productPrice.toString(),
                            keyboardType: TextInputType.number,
                            decoration: textDecoration,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Text(
                          'PRODUCT SELLER',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredProductSeller = newValue!;
                            },
                            initialValue: product.productSeller,
                            keyboardType: TextInputType.name,
                            decoration: textDecoration,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Text(
                          'PRODUCT STOCK',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredProductStock = newValue!;
                            },
                            initialValue: product.productStock.toString(),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: textDecoration,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Text(
                          'PRODUCT DESCRIPTION',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredProductDescription = newValue!;
                            },
                            initialValue: product.productDescription,
                            keyboardType: TextInputType.name,
                            decoration: textDecoration,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Text(
                          'PRODUCT IMAGE URL',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 12),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredProductImageURL = newValue!;
                            },
                            initialValue: product.productImageURL,
                            keyboardType: TextInputType.name,
                            decoration: textDecoration,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 12),
                          ),
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
                              onPressed: () {
                                updateForm(product.productID);
                              },
                              child: Text(
                                'UPDATE',
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
                );
              }
              return const Center(
                child: Text('Loading...'),
              );
            },
          ),
        ),
      ),
    );
  }
}
