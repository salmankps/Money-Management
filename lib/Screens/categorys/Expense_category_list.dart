import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';

import '../../models/category_model/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListner,
        builder: (BuildContext ctx, List<CategoryModel>newlist,Widget? _){
      return ListView.separated(
        itemBuilder: (context,index){
          final category = newlist[index];
          return ListTile(
            title: Text(category.name),
            trailing: IconButton(
              icon: Icon(Icons.delete_outline_rounded),
              onPressed: (){
                CategoryDB.instance.deleteCategory(category.id);
              },
            ),
            tileColor: Colors.white,
            iconColor: Colors.red,


          );
        },
        separatorBuilder:(context,index){
          return SizedBox(height: 10,);
        },
        itemCount: newlist.length,
      );
    }
    );
  }
}
