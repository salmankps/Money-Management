import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/transactions/transaction_db.dart';
import 'package:moneymanagement/models/category_model/category_model.dart';
import 'package:moneymanagement/models/transaction_model/transaction_model.dart';

class ScreenAddTransactions extends StatefulWidget {
  static const routName = 'add-transaction';

  const ScreenAddTransactions({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransactions> createState() => _ScreenAddTransactionsState();
}

class _ScreenAddTransactionsState extends State<ScreenAddTransactions> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Purpose'),
                controller: _purposeTextEditingController,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount'),
                controller: _amountTextEditingController,
              ),

              //Calender

              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 35)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate.toString()),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text("Income"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text("Expense"),
                    ],
                  )
                ],
              ),
//CategoryType
              DropdownButton(
                  hint: Text('Select Category'),
                  value: _categoryID,
                  items: (_selectedCategoryType == CategoryType.income
                          ? CategoryDB.instance.incomeCategoryListListner
                          : CategoryDB.instance.expenseCategoryListListner)
                      .value.map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: (){
                        _selectedCategoryModel =e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                  setState(() {
                    _categoryID = selectedValue;
                  });
                  }),

              //Submit
              ElevatedButton.icon(
                icon: Icon(Icons.check_circle),
                onPressed: () {
                  addTransaction();

                },
                label: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void>addTransaction()async{
    final _purposeText =_purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if(_purposeText.isEmpty){
      return;
    }
    if(_amountText.isEmpty){
      return;
    }
    // if(_categoryID== null){
    //   return;
    // }
    if(_selectedDate == null){
        return;
    }
    if(_selectedCategoryModel == null){
      return;
    }
   final _parsedAmount = double.tryParse(_amountText);
    if(_parsedAmount == null) {
      return;
    }
// _selectedDate
// _selectedCategoryType
// _categoryID
  final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
  );
 await TransactionDB.instance.addTransaction(_model);
 Navigator.of(context).pop();
 TransactionDB.instance.refresh();
  }
}
