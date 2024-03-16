import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varchandise/models/cart_models.dart';

class ListCartUI extends StatelessWidget {
  const ListCartUI(
      {super.key,
      required this.listCart,
      required this.customerEmail,
      required this.index,
      required this.addItem,
      required this.checkItem,
      required this.deleteItem,
      required this.reduceItem});

  final List<Cart> listCart;
  final int index;
  final String customerEmail;
  final void Function(String, int, bool) addItem;
  final void Function(String, int, bool) reduceItem;
  final void Function(String, int, bool) checkItem;
  final void Function(String, String) deleteItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        width: 200,
        height: 110,
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(listCart[index].imgURL),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 120,
                      child: Text(
                        listCart[index].productTitle,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Text(
                    listCart[index].category.name,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color.fromRGBO(0, 0, 0, 0.7)),
                  ),
                  Text(
                    'Stock: ${listCart[index].productStock}',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color.fromRGBO(0, 0, 0, 0.7)),
                  ),
                  Flexible(
                    child: Text(
                      listCart[index].getFormattedProductPrice,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                            width: 1.0, color: Color(0xff7408C2)),
                      ),
                      activeColor: const Color(0xff7408C2),
                      value: listCart[index].isSelected,
                      onChanged: (value) {
                        listCart[index].isSelected =
                            !listCart[index].isSelected;
                        checkItem(
                            listCart[index].cartID,
                            listCart[index].cartAmount,
                            listCart[index].isSelected);
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          onPressed: () {
                            deleteItem(listCart[index].cartID, customerEmail);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.trash,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: listCart[index].cartAmount == 1
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  size: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  reduceItem(
                                      listCart[index].cartID,
                                      listCart[index].cartAmount,
                                      listCart[index].isSelected);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  size: 12,
                                  color: Color(0xff7408C2),
                                ),
                              ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          listCart[index].cartAmount.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        height: 20,
                        width: 20,
                        child: IconButton(
                          onPressed: () {
                            addItem(
                                listCart[index].cartID,
                                listCart[index].cartAmount,
                                listCart[index].isSelected);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.plus,
                            size: 12,
                            color: Color(0xff7408C2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
