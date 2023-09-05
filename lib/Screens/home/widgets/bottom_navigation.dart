import 'package:flutter/material.dart';
import 'package:moneymanagement/Screens/home/screen_home.dart';

class MoneyManageBotttomNavigation extends StatelessWidget {
  const MoneyManageBotttomNavigation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx,int updatedIndex, _){
        return BottomNavigationBar(
          selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.blue,
            currentIndex: updatedIndex,
            onTap: (newIndex){
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            items:const [
              BottomNavigationBarItem(

                  icon: Icon(Icons.home),
                  label: 'Transactions'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categorys'

              )
            ]
        );
      },
    );
  }
}
