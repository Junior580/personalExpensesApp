import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/chart.dart';
import 'components/transaction_form.dart';

import '/models/transaction.dart';
import 'components/transaction_list.dart';
import 'components/app_bar_top.dart';

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

  bool _showChart = false;

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
        isScrollControlled: true,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  Widget _getIconButton(IconData icon, void Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    final midiaQuery = MediaQuery.of(context);

    bool isLandscape = midiaQuery.orientation == Orientation.landscape;

    final iconList = isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart = isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : iconChart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final appBar = AppBarTop(actions: actions);

    final availableHeight = midiaQuery.size.height -
        appBar.preferredSize.height -
        midiaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text('Exibir Gráfico'),
            //       Switch.adaptive(
            //           activeColor: Theme.of(context).primaryColor,
            //           value: _showChart,
            //           onChanged: (value) {
            //             setState(() {
            //               _showChart = value;
            //             });
            //           }),
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              SizedBox(
                  height: availableHeight * (isLandscape ? 0.8 : 0.3),
                  child: Chart(recentTransaction: _recentTransactions)),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                    transactions: _transactions, onRemove: _deleteTransaction),
              ),
          ],
        ),
      ),
    );

    return isIOS
        ? CupertinoPageScaffold(navigationBar: appBar, child: bodyPage)
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
