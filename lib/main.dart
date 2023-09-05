import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/Screens/add_transaction/add_transation.dart';
import 'package:moneymanagement/Screens/home/screen_home.dart';
import 'package:moneymanagement/models/category_model/category_model.dart';

import 'models/transaction_model/transaction_model.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();

  if(! Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

 if(! Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
   Hive.registerAdapter(CategoryModelAdapter());
 }
  if(! Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
      theme: ThemeData.dark(),
      routes: {
ScreenAddTransactions.routName:(ctx)=>const ScreenAddTransactions(),
      },
    );
  }
}

