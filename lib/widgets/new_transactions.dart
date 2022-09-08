import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({super.key});

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = amountController.text;

    if (enteredTitle.isEmpty || enteredAmount.isEmpty) {
      return;
    }

    final enteredAmountInt = double.parse(enteredAmount);

    if (enteredAmountInt <= 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmountInt);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) =>
                  submitData(), //::FOR HAVING TO SEND IT, BUT IT WAS MADE ANONYMOUS
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) =>
                  submitData(), //::FOR HAVING TO SEND IT, BUT IT WAS MADE ANONYMOUS
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text('No Date Chosen!'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: submitData,
                child: Text('Add Transactions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor:
                      Theme.of(context).textTheme.labelLarge?.color,
                ))
          ],
        ),
      ),
    );
  }
}
