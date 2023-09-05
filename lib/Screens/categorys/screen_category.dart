import 'package:flutter/material.dart';
import 'package:moneymanagement/Screens/categorys/Expense_category_list.dart';
import 'package:moneymanagement/Screens/categorys/income_category_list.dart';
import 'package:moneymanagement/db/category/category_db.dart';

class  ScreenCategory extends StatefulWidget {
  const ScreenCategory ({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>with SingleTickerProviderStateMixin {
 late TabController _tabController ;
 @override
  void initState() {
   _tabController = TabController(length: 2, vsync: this);
   CategoryDB().refreshUI();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
            tabs: [

              Tab(text: 'INCOME',),
              Tab(text: 'EXPENSE',)
            ],),
        Expanded(
          child: TabBarView(
            controller: _tabController,
              children: [
                IncomeCategoryList(),
                ExpenseCategoryList(),
              ]
          ),
        )
      ],
    );
  }
}
