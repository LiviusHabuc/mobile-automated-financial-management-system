import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/transactions_provider.dart';
import '../utils/styling.dart';

class FilterTransactions extends StatefulWidget {
  final Transactions transactions;

  FilterTransactions(this.transactions);

  @override
  _FilterTransactionsState createState() => _FilterTransactionsState();
}

class _FilterTransactionsState extends State<FilterTransactions> {
  DateTime? _selectedFromDate;

  DateTime? _selectedToDate;

  final List<String> _sortingStrategies = ["None", "Ascending", "Descending"];

  String _selectedSortingStrategy = "None";

  void _submitData() {
    String fromDateString = "";
    String toDateString = "";

    if (_selectedFromDate != null) {
      fromDateString = "${_selectedFromDate!.toIso8601String()}Z";
    }
    if (_selectedToDate != null) {
      toDateString = "${_selectedToDate!.toIso8601String()}Z";
    }

    widget.transactions
        .getAllTransactionsFiltered(fromDateString, toDateString, _selectedSortingStrategy);

    Navigator.of(context).pop();
  }

  void _presentFromDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedFromDate = pickedDate;
      });
    });
  }

  void _presentToDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedToDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.primaryWithOpacityColor,
      child: SingleChildScrollView(
        child: Card(
          color: Styles.primaryWithOpacityColor,
          surfaceTintColor: Styles.primaryWithOpacityColor,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedFromDate == null
                              ? "No date chosen!"
                              : "Filter from: ${DateFormat("dd/MM/yyyy").format(_selectedFromDate!)}",
                          style: TextStyle(
                            color: Styles.whiteColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _presentFromDatePicker,
                        child: const Text(
                          "Choose from date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedToDate == null
                              ? "No date chosen!"
                              : "Filter to: ${DateFormat("dd/MM/yyyy").format(_selectedToDate!)}",
                          style: TextStyle(
                            color: Styles.whiteColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _presentToDatePicker,
                        child: const Text(
                          "Choose to date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Sort transactions by value",
                          style: TextStyle(
                            color: Styles.whiteColor,
                          ),
                        ),
                      ),
                      DropdownButton(
                        dropdownColor: Styles.accentColor,
                        iconEnabledColor: Styles.blueColor,
                        underline: Container(
                          height: 2,
                          color: Styles.blueColor,
                        ),
                        value: _selectedSortingStrategy,
                        items: _sortingStrategies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Styles.whiteColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSortingStrategy = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.blueColor,
                  ),
                  child: const Text("Apply filters"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
