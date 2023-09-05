import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/transactions/transaction_db.dart';
import 'package:moneymanagement/models/category_model/category_model.dart';

import '../../models/transaction_model/transaction_model.dart';

class  ScreenTransaticon extends StatelessWidget {
 const  ScreenTransaticon ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel>newList,Widget ?_){
          return ListView.separated(
            padding: EdgeInsets.all(10),

            
            //values
            itemBuilder: (ctx,index){
              final _value =newList[index];
              return  Slidable(
                key: Key(_value.id!),
                startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (ctx){
                            TransactionDB.instance.deleteTransaction(_value.id!);
                          },
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ]
                ),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(parseDate(_value.date),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: _value.type ==CategoryType.income
                          ? Colors.green:Colors.red,
                      radius: 50,
                    ),
                    title: Text('RS ${_value.amount}'),
                    subtitle: Text(_value.category.name),

                  ),
                ),
              );
            },
            separatorBuilder: (context, index){
              return SizedBox();
            },
            itemCount: newList.length,
          );
        }
    );

  }
  String parseDate(DateTime date){
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
   // return '${date.day}\n${date.month}';
  }
}
