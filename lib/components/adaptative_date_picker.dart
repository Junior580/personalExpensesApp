import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateChange;

  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }

        onDateChange(pickedDate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2023),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data Selecionada: ${DateFormat('d/M/y').format(selectedDate)}'),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text('Selecionar data',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          );
  }
}
