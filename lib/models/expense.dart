import 'dart:convert';

import 'package:expense/utils/helper.dart';
import 'category.dart';

class Expense {
  final String _id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : _id = uuid.v4();

  String get id => _id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': _id,
      'title': title,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'category': category
    };
  }

  String get formatedDate => dateFormater.format(date);

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map['title'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as Category,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $_id, title: $title, amount: $amount, date: $date, category: $category)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == _id &&
        other.title == title &&
        other.amount == amount &&
        other.date == date &&
        other.category == category;
  }

  @override
  int get hashCode {
    return _id.hashCode ^
        title.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        category.hashCode;
  }
}
