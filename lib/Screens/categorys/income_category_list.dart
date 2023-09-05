import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../models/category_model/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListner,
        builder: (BuildContext ctx, List<CategoryModel>newlist,Widget? _){
          return ListView.separated(
            itemBuilder: (context,index){
              final category = newlist[index];
              return ListTile(
                title: Text(category.name),
                trailing:  IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    CategoryDB.instance.deleteCategory(category.id);
                  },
                ),
                tileColor: Colors.white,
                iconColor: Colors.green,


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
