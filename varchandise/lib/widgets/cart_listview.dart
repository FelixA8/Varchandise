import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/models/cart_models.dart';
import 'package:varchandise/rest/cartlist_api.dart';
import 'package:varchandise/rest/get_history_api.dart';
import 'package:varchandise/screens/purchase_success_screen.dart';
import 'package:varchandise/widgets/cart_individual_ui.dart';

class CartListView extends StatefulWidget {
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  SharedPreferences? sharedPreferences;
  String customerEmail = "";

  Future getCustomerMail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    customerEmail = sharedPreferences!.getString('usermail').toString();
    Future<List<Cart>>? listOfCart;
    listOfCart = getAllUserCart(customerEmail);
    return listOfCart;
  }

  String getFormattedProductPrice(price) {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
        .format(price);
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
                    'The amount you requested is exceeding the product stock.',
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
    void addItem(String cartID, int cartAmount, bool isSelected) async {
      cartAmount += 1;
      await updateNewUserCart(cartID, customerEmail, cartAmount, isSelected);
      setState(() {});
    }

    void reduceItem(String cartID, int cartAmount, bool isSelected) async {
      cartAmount -= 1;
      await updateNewUserCart(cartID, customerEmail, cartAmount, isSelected);
      setState(() {});
    }

    void checkItem(String cartID, int cartAmount, bool isSelected) async {
      await updateNewUserCart(cartID, customerEmail, cartAmount, isSelected);
      setState(() {});
    }

    void deleteItem(String cartID, String customerEmail) async {
      await deleteUserCart(cartID, customerEmail);
      setState(() {});
    }

    return FutureBuilder(
      future: getCustomerMail(),
      builder: (context, snapshot) {
        bool anySelectedItem = false;
        int totalPrice = 0;

        if (snapshot.hasData) {
          List<Cart> listCart =
              snapshot.data as List<Cart>; // cast to List<Marker>
          for (int i = 0; i < listCart.length; i++) {
            if (listCart[i].isSelected == true) {
              anySelectedItem = true;
              totalPrice += (listCart[i].price * listCart[i].cartAmount);
            }
          }

          return listCart.isEmpty
              ? const Center(
                  child: Text('No Cart'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCart.length,
                        itemBuilder: (context, index) {
                          return ListCartUI(
                            listCart: listCart,
                            customerEmail: customerEmail,
                            addItem: addItem,
                            reduceItem: reduceItem,
                            checkItem: checkItem,
                            deleteItem: deleteItem,
                            index: index,
                          );
                        },
                      ),
                    ),
                    anySelectedItem
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 36),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total:       ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(getFormattedProductPrice(totalPrice),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ActionSlider.standard(
                                    sliderBehavior: SliderBehavior.stretch,
                                    rolling: true,
                                    width: double.infinity,
                                    backgroundColor: Colors.white,
                                    toggleColor: const Color(0xff7408C2),
                                    iconAlignment: Alignment.centerRight,
                                    loadingIcon: const SizedBox(
                                      width: 55,
                                      child: Center(
                                        child: SizedBox(
                                          width: 24.0,
                                          height: 24.0,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    successIcon: const SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Icon(Icons.check_rounded))),
                                    icon: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        "images/CartButton.jpg",
                                      ),
                                    ),
                                    action: (controller) async {
                                      bool overAmount = false;
                                      for (int i = 0;
                                          i < listCart.length;
                                          i++) {
                                        if (listCart[i].isSelected == true &&
                                            listCart[i].productStock <
                                                listCart[i].cartAmount) {
                                          overAmount = true;
                                          break;
                                        }
                                      }
                                      if (overAmount == false) {
                                        for (int i = 0;
                                            i < listCart.length;
                                            i++) {
                                          if (listCart[i].isSelected == true) {
                                            await updateProductStock(
                                                listCart[i].productID,
                                                listCart[i].cartAmount);
                                            await createUserHistory(
                                                customerEmail,
                                                listCart[i].productID,
                                                listCart[i].cartAmount,
                                                listCart[i].price);
                                            await deleteUserCart(
                                                listCart[i].cartID,
                                                customerEmail);
                                          }
                                        }
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SuccessPurchaseScreen(),
                                              ));
                                        });
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        controller.reset(); //resets the slider
                                      } else {
                                        showAlertDialog(context);
                                      }
                                    },
                                    child: Text(
                                      'Swipe right to purchase',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 36,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
        }
        return const Center();
      },
    );
  }
}
