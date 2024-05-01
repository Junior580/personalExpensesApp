import 'dart:math';
import 'package:flutter/material.dart';
import 'components/chart.dart';
import 'components/transaction_form.dart';

import '/models/transaction.dart';
import 'components/transaction_list.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.purple,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                    titleMedium: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                )),
            appBarTheme: const AppBarTheme()),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 400.76,
      date: DateTime.now().subtract(const Duration(days: 32)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tenis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.31,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Credit card',
      value: 249.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Lanche',
      value: 249.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Roupas',
      value: 302.77,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't6',
      title: 'Jogo do bixo',
      value: 110.80,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransaction: _recentTransactions),
            TransactionList(
                transactions: _transactions, onRemove: _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
