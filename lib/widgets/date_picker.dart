import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime dateResponseData) setDateResponse;
  final DateTime setDateData;
  DatePicker({
    @required this.setDateResponse,
    @required this.setDateData,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateResponse;

  @override
  void initState() {
    super.initState();
    //_dateResponse = DateTime.now();
    _dateResponse = widget.setDateData;
    widget.setDateResponse(_dateResponse);
    print('Work 2: $_dateResponse');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 3,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${DateFormat('MMMM dd, yyyy').format(_dateResponse)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final errorCaseDate = _dateResponse;
              _dateResponse = await showDatePicker(
                context: context,
                initialDate: _dateResponse,
                firstDate: _dateResponse.isAfter(DateTime.now())
                    ? DateTime.now()
                    : _dateResponse,
                lastDate: DateTime(2100),
              );
              //print(dateResponse);
              if (_dateResponse != null) {
                setState(() {
                  print('Work 3 !null: $_dateResponse');
                  widget.setDateResponse(_dateResponse);
                });
              } else {
                setState(
                  () {
                    _dateResponse = errorCaseDate;
                    print('Work 4 null: $_dateResponse');
                    widget.setDateResponse(_dateResponse);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
