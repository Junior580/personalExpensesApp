import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    super.key,
    this.label = '',
    this.value = 0,
    this.percentage = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(value.toStringAsFixed(2))),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(220, 220, 220, 1)),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
