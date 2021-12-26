import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_expenses_planner/widgets/user_transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/Transaction_list.dart';
import './models/Transaction.dart';
import './widgets/chart.dart';
import './widgets/user_transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
        secondaryHeaderColor: Colors.yellow,
        primaryTextTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
        // appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
        //   Title:Textstyle(fontFaimly: primarytextTheme),
        // ),
        // )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //String titleInput;
  //String amountInput;
  final List<Transaction> userTransaction = [
    // Transaction(
    //     id: 't1', title: 'New Shirt', money: 1999.99, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Jeans', money: 1233.99, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Shoes', money: 3977.00, date: DateTime.now()),
  ];
  bool showchart = false;
  List<Transaction> get recentTransaction {
    return userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addnewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txtitle,
        money: txamount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      userTransaction.add(newTx);
    });
  }

  void startaddingTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: newTransaction(addnewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteTransiction(String id) {
    setState(() {
      userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(
      title: Text(
        'Expenses Planner',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => (startaddingTransaction(context)),
        ),
      ],
    );
    // final txlist = Container(
    //   //color: Colors.lightBlue,
    //   child: Card(
    //     color: Colors.purple,
    //     child: Text('ADD YOUR EXPENSES HERE',
    //         style: TextStyle(
    //           fontSize: 30,
    //           color: Colors.black,
    //         )),
    //     elevation: 15,
    //   ),
    // );
    final txtrans = Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: Transaction_list(userTransaction, deleteTransiction),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (islandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show Chart'),
                    Switch(
                      value: showchart,
                      onChanged: (val) {
                        setState(() {
                          showchart = val;
                        });
                      },
                    ),
                  ],
                ),
              if (!islandscape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(recentTransaction),
                ),
              if (!islandscape) txtrans,
              if (islandscape)
                showchart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appbar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: Chart(recentTransaction),
                      )
                    // : Container(
                    //     //color: Colors.lightBlue,
                    //     child: Card(
                    //       color: Colors.purple,
                    //       child: Text('ADD YOUR EXPENSES HERE',
                    //           style: TextStyle(
                    //             fontSize: 30,
                    //             color: Colors.black,
                    //           )),
                    //       elevation: 15,
                    //     ),
                    //   ),
                    : txtrans
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => (startaddingTransaction(context)),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
