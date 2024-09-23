import 'package:expance_traker/app_imports.dart';
import 'package:flutter/foundation.dart';


class HiveServices {
  String boxName = 'Expense';

  Future<Box<TransactionData>> openBox() async {
    return await Hive.openBox<TransactionData>(boxName);
  }

  ValueListenable<Box<TransactionData>> getExpenseListenable() {
    return Hive.box<TransactionData>(boxName).listenable();
  }

  Future<void> addExpense(TransactionData value) async {
    var box = await openBox();
    await box.add(value);
  }

  Future<List<TransactionData>> getAllExpense() async {
    var box = await openBox();
    return box.values.toList();
  }

  Future<void> updateExpense(int index, value) async {
    var box = await openBox();
    return box.putAt(index, value);
  }

  Future<void> deleteExpense(int index) async {
    var box = await openBox();
    return box.deleteAt(index);
  }
}