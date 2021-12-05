import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

class Transaction_list extends StatelessWidget {
  final List<Transaction> transictions;
  final Function deleteTx;

  Transaction_list(this.transictions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: transictions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transiction done yet",
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // Image.asset('assets/images/zero.png'),
                  height: 100,
                  child: Image.asset('lib/assets/images/zero.png',
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${transictions[index].money}',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transictions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMMd().format(transictions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).primaryColor,
                      onPressed: () => deleteTx(transictions[index].id),
                    ),
                  ),
                );
                // {
                // return Card(
                //   color: Theme.of(context).secondaryHeaderColor,
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           horizontal: 10,
                //           vertical: 15,
                //         ),
                //         decoration: BoxDecoration(
                //             color: Theme.of(context).primaryColor,
                //             border: Border.all(
                //               color: Colors.red,
                //               width: 2,
                //             )),
                //         child: Text(
                //           '\₹' + transictions[index].money.toStringAsFixed(2),
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 25,
                //             color: Theme.of(context).secondaryHeaderColor,
                //           ),
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.all(10),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Text(
                //             transictions[index].title,
                //             style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black),
                //           ),
                //           Text(DateFormat.yMMMd()
                //               .format(transictions[index].date)),
                //         ],
                //       )
                //     ],
                //   ),
                // );
                // }
              },
              itemCount: transictions.length,
            ),
    );
  }
}
