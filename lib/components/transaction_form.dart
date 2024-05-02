import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
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
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              AdaptativeTextField(
                controller: _titleController,
                onChanged: (_) => _submitForm(),
                label: 'Título',
              ),
              AdaptativeTextField(
                controller: _valueController,
                onChanged: (_) => _submitForm(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                label: 'Valor (R\$)',
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data Selecionada: ${DateFormat('d/M/y').format(_selectedDate)}'),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text('Selecionar data',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    onPressed: _submitForm,
                    label: 'Nova Transação',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
