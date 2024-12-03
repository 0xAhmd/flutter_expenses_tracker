import 'package:expenses_tracker_flutter/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;
  List<ExpenseModel> _allExpenses = [];

  // setup database

  static Future<void> setupDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open([ExpenseModelSchema], directory: dir.path);
  }

  // get all expenses(getters)

  List<ExpenseModel> get allExpenses => _allExpenses;

  // O P E R A T I O N S

// Create , Read , Update , Delete operations

  Future<void> addExpense(ExpenseModel expense) async {
    await isar.writeTxn(() => isar.expenseModels.put(expense));

    await getExpenses();
  }

  Future<void> getExpenses() async {
    List<ExpenseModel> fetchedExpenses =
        await isar.expenseModels.where().findAll();

    _allExpenses.clear();
    _allExpenses.addAll(fetchedExpenses);
    notifyListeners();
  }

  Future<void> updateExpense(int id, ExpenseModel expense) async {
    expense.id = id;

    await isar.writeTxn(() => isar.expenseModels.put(expense));

    await getExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() => isar.expenseModels.delete(id));

    await getExpenses();
  }

  // H E L P E R
}
