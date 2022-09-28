import 'dart:io';

import 'package:combining_widgets/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({super.key});

  final Function addTx;

  NewTransaction(this.addTx) {
    print('constructor newTransaction widget');
  }

  @override
  _NewTransactionState createState() {
    print('Create state NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionState() {
    print('Constructor New Transaction State');
  }

  @override
  void initState() {
    // TODO: implement initState
    print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose()');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 200,
              // right: MediaQuery.of(context).viewInsets.bottom + 10
              right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) =>
                    _submitData(), //::FOR HAVING TO SEND IT, BUT IT WAS MADE ANONYMOUS
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) =>
                    _submitData(), //::FOR HAVING TO SEND IT, BUT IT WAS MADE ANONYMOUS
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _submitData,
                  child: Text('Add Transactions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor:
                        Theme.of(context).textTheme.labelLarge?.color,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
