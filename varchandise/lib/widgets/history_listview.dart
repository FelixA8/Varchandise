import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/models/history_models.dart';
import 'package:varchandise/rest/get_history_api.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({super.key});

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  SharedPreferences? sharedPreferences;
  String usermail = "";

  Future getCustomerEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    usermail = sharedPreferences!.getString('usermail').toString();
    Future<List<History>>? listOfHistory;
    listOfHistory = getUserHistory(usermail);
    return listOfHistory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCustomerEmail(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<History> listHistory =
              snapshot.data as List<History>; // cast to List<Marker>
          return listHistory.isEmpty
              ? const Center(
                  child: Text("Oops, you do not have any history of buying"),
                )
              : ListView.builder(
                  itemCount: listHistory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listHistory[index].formatDate,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
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
                            width: double.infinity,
                            height: 130,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Row(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 88 / 88,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: Colors.grey),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                            listHistory[index].imgURL),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        listHistory[index].productName,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${listHistory[index].purchasedAmount.toString()} items',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 0.7)),
                                      ),
                                      Text(
                                        'Status: Paid',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                      Text(
                                        listHistory[index]
                                            .getFormattedProductPrice,
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                      Text(
                                        'Total Price: ${listHistory[index].getFormattedTotalPrice}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        }
        if (snapshot.hasError) {
          // getMarkers() throws an exception
          return Center(child: Text(snapshot.error.toString()));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
