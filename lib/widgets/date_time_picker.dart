import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  final String hintText;
  final DateTime initValue;
  final TextEditingController dateController;
  final Function(DateTime pickedValue) onSelectValue;

  const DateTimePicker({
    Key key,
    this.hintText,
    @required this.initValue,
    @required this.dateController,
    this.onSelectValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText != null ? hintText : ""),
      onTap: () async {
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: initValue,
          lastDate: DateTime(2101),
          firstDate: DateTime(2015, 8),
        );
        if (picked != null) {
          var formattedDateTime = new DateFormat.yMMMd().format(picked);
          dateController.text = formattedDateTime.toString();
          onSelectValue(picked);
        }
      },
      controller: dateController,
    );
  }
}
