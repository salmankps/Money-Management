import 'package:flutter/material.dart';
import 'package:moneymanagement/Screens/add_transaction/add_transation.dart';
import 'package:moneymanagement/Screens/categorys/screen_category.dart';
import 'package:moneymanagement/Screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanagement/Screens/transatcions/screen_transatcion.dart';

import '../categorys/categoryAddPopup.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier <int> selectedIndexNotifier = ValueNotifier(0);
  final _pages =const [
    ScreenTransaticon(),
    ScreenCategory(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Money Manager"),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManageBotttomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context,int updatedIndex,_){
            return _pages[updatedIndex];
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
              color: Colors.lightBlueAccent,
              width: 6,
              style: BorderStyle.solid,
              strokeAlign: 34,

          )
        ),
        onPressed: (){
          if(selectedIndexNotifier.value== 0){
            print("Add Transactions");
            Navigator.of(context).pushNamed(ScreenAddTransactions.routName);

          }else{
            print("Add Category");
            showCategoryAddPopup(context);
          }
        },

      ),

    );
  }
}
