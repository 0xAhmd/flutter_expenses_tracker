import 'package:isar/isar.dart';

part 'expense_model.g.dart'; // this line to generate the isar file
@Collection() // decorator
class ExpenseModel {
  // model for expense
  Id id = Isar.autoIncrement;
  final String title;
  final double amount;
  final DateTime date;

ExpenseModel({required this.title, required this.amount, required this.date});

}
