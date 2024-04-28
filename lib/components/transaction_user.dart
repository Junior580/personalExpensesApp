import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp2/models/transaction.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUser();
}

class _TransactionUser extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tenis de corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.31,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'produto #3',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'produto #4',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'produto #5',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'produto #5',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'produto #5',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'produto #6',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'produto #7',
      value: 310.76,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    print('_addTransaction: ${newTransaction.title}');

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(
          onSubmit: _addTransaction,
        ),
        TransactionList(transactions: _transactions),
      ],
    );
  }
}
