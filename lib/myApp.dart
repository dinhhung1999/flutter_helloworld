import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'transaction.dart';
import 'package:flutter_app_demo1/transactionList.dart';
class MyApp extends StatefulWidget {
  String name;
  int age;
  MyApp({this.name, this.age});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  // String _email=''; // this is state
  // final emailEdittingContronller = TextEditingController();
  final _contentEdittingController = TextEditingController();
  final _amountEdittingController = TextEditingController();
  Transaction _transaction = Transaction(content: '',amount: 0.0);
  List<Transaction> _transactions = List<Transaction>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print('Run initState()');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print("Run dispose()");
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused) {
      print('App is in background mode');
    }
    else if ( state == AppLifecycleState.resumed) {
      print('App is in foreground mode');
    }
  }
  @override
  Widget build(BuildContext context) {
    // print("run build()");
    // DateTime now = new DateTime.now();
    // DateTime someDate = new DateTime(2020,10,20);
    return MaterialApp(
      title: "Demo my app",
      home: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          minimum: const EdgeInsets.only(left: 20,right: 20,top:40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: const BorderRadius.all(const Radius.circular(20)),
                //         ),
                //         labelText: 'Enter the text '
                //     ),
                //     controller: emailEdittingContronller,
                //     onChanged: (text){
                //       this.setState(() {
                //         _email = text; // when state changed => build return => reload widget
                //       });
                //     },
                //   ),
                // ),
                // Text(
                //   '$_email',
                //   style: TextStyle(fontSize: 30,color: Colors.red),
                // ),Text(
                //   'This is line 3',
                //   style: TextStyle(fontSize: 30,color: Colors.red),
                // )
                TextField(
                  decoration: InputDecoration(labelText: 'Content'),
                  controller: _contentEdittingController,
                  onChanged: (text){
                    setState(() {
                      _transaction.content = text;
                    });
                  },
                ),TextField(
                  decoration: InputDecoration(labelText: 'Amount(money'),
                  controller: _amountEdittingController,
                  onChanged: (text){
                    setState(() {
                      _transaction.amount = double.tryParse(text) ?? 0;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                ButtonTheme(
                  height: 60,
                  child:  FlatButton(
                    child: Text('Insert Transaction', style: const TextStyle(fontSize: 18),),
                    color: Colors.pinkAccent,
                    textColor: Colors.white,
                    onPressed: (){
                      setState(() {
                        _transactions.add(_transaction);
                        _transaction = Transaction(content: '',amount: 0.0);
                        _contentEdittingController.text = '';
                        _amountEdittingController.text ='';
                      });
                      // print('You pressed this button');

                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Consaction list : '+ _transaction.toString()),
                            duration: Duration(seconds: 3),
                          )
                      );
                    },
                  ),
                ),
                TransactionList(transactions: _transactions)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
