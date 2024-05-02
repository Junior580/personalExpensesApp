import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarTop extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final List<Widget> actions;
  const AppBarTop({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontSize: 20 * MediaQuery.textScalerOf(context).scale(1),
              ),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: actions),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontSize: 20 * MediaQuery.textScalerOf(context).scale(1),
              ),
            ),
            actions: actions,
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  bool shouldFullyObstruct(BuildContext context) => false;
}
