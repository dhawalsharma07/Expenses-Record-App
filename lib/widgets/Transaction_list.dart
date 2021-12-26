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
    return transictions.isEmpty
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
            },
            itemCount: transictions.length,
          );
  }
}
