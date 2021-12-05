import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class newTransaction extends StatefulWidget {
  final Function addTx;

  newTransaction(this.addTx);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  var titleController = TextEditingController();

  var amountController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  // @override
  // void initState() {
  //   super.initState();
  //   selectedDate = DateTime.now();
  // }

  @override
  void submit() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
    print('....');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,

              onSubmitted: (_) => submit(),
              //onChanged: (val) {
              //titleInput = val;
              //},
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit(),
              // onChanged: (val) {
              // amountInput = val;
              //},
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(
                    selectedDate == null
                        ? 'No date Chosen '
                        : 'Picked Date :${DateFormat.yMd().format(selectedDate)}',
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Tansaction'),
              textColor: Colors.white,
              color: Colors.purple,
              onPressed: submit,
              //print(titleInput);
              //print(amountInput);
              //print(titleController.text);
              //print(amountController.text);
            )
          ],
        ),
      ),
    );
  }
}
