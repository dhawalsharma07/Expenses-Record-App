import 'package:flutter/material.dart';
import './Transaction_list.dart';
import './new_transaction.dart';
import '../models/Transaction.dart';

class userTransaction extends StatefulWidget {
  @override
  _userTransactionState createState() => _userTransactionState();
}

class _userTransactionState extends State<userTransaction> {
  final List<Transaction> userTransaction = [
    // Transaction(
    //    id: 't1', title: 'New Shirt', money: 1999.99, date: DateTime.now()),
    //Transaction(id: 't2', title: 'Jeans', money: 1233.99, date: DateTime.now()),
    //Transaction(id: 't3', title: 'Shoes', money: 3977.00, date: DateTime.now()),
  ];

  void addnewTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
        title: txtitle,
        money: txamount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // newTransaction(addnewTransaction),
        // Transaction_list(userTransaction)
      ],
    );
  }
}
