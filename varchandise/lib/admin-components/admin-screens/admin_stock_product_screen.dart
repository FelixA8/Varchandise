import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/admin-components/admin-rest-api/admin_login.dart';
import 'package:varchandise/admin-components/admin-screens/admin_home_screen.dart';
import 'package:varchandise/admin-components/admin-screens/admin_update_product_screen.dart';
import 'package:varchandise/admin-components/admin_bearertoken.dart' as bt;
import 'package:varchandise/models/product_models.dart';

class AdminStockProductScreen extends StatefulWidget {
  const AdminStockProductScreen({super.key});

  @override
  State<AdminStockProductScreen> createState() =>
      _AdminStockProductScreenState();
}

class _AdminStockProductScreenState extends State<AdminStockProductScreen> {
  Future getAllProduct() async {
    Future<List<Product>>? listOfCart;
    listOfCart = getAllAdminProduct(bt.bearerToken);
    return listOfCart;
  }

  void deleteProduct(String id) async {
    await deleteSpecificAdminProduct(bt.bearerToken, id);
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AdminHomeScreen(),
            settings: const RouteSettings(name: "/home")));
  }

  deleteProductAlertDialog(BuildContext context, String id) {
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
                        "Do you want to Delete Product? User's history and cart related to the product removed.",
                        style: GoogleFonts.poppins(fontSize: 14),
                        textAlign: TextAlign.center,
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
                                deleteProduct(id);
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

  @override
  Widget build(BuildContext context) {
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
          'Current Stock and Products',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
          future: getAllProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> listProduct = snapshot.data as List<Product>;
              return ListView.builder(
                itemCount: listProduct.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 130,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            offset: Offset(0, 5),
                            spreadRadius: -6),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: AspectRatio(
                                  aspectRatio: 73 / 78,
                                  child: Image.network(
                                      listProduct[index].productImageURL),
                                ),
                              ),
                              const SizedBox(
                                width: 23,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listProduct[index].productName,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      listProduct[index].productCategory.name,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      listProduct[index].getFormattedPrice,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Current Stock: ${listProduct[index].productStock.toString()}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminUpdateProductScreen(
                                                productID: listProduct[index]
                                                    .productID),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xff0075B7),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'UPDATE',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    deleteProductAlertDialog(
                                        context, listProduct[index].productID);
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffDC0000),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'DELETE',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text('No Items'),
            );
          },
        ),
      ),
    );
  }
}
