import 'package:flutter/material.dart';
import 'transaction.dart';
// ignore: must_be_immutable
class TransactionList extends StatelessWidget{
  List<Transaction> transactions;
  TransactionList({this.transactions});
  ListView _buildListView(){
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: (index -1) % 2 == 0 ? Colors.teal : Colors.green,
          elevation: 10,
          child: ListTile(
            leading: const Icon(Icons.access_alarm),
            title: Text(transactions[index].content, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            subtitle: Text('Price : ${transactions[index].amount}', style: TextStyle(fontSize: 15, color: Colors.white),),
            onTap: (){
              print('You clicked ${transactions[index].content}');
            },
          ),
        );
      }
    );
    // transactions.map((eachTransaction){
    //   index ++;
    //
    // }).toList();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 500,
      child: this._buildListView(),
    );
  }
}