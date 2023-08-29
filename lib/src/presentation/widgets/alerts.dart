import 'package:flutter/material.dart';

class AlertSettingsWidget extends StatefulWidget {
  const AlertSettingsWidget({super.key});

  @override
  _AlertSettingsWidgetState createState() => _AlertSettingsWidgetState();
}

class _AlertSettingsWidgetState extends State<AlertSettingsWidget> {
  bool _isAlertEnabled = false;
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enable budget Alert'),
            Switch(
              value: _isAlertEnabled,
              onChanged: (value) {
                setState(() {
                  _isAlertEnabled = value;
                });
              },
            ),
          ],
        ),
        if (_isAlertEnabled)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Set Time'),
                subtitle: Text(_selectedTime.format(context)),
                onTap: () => _selectTime(context),
              ),
              ListTile(
                title: const Text('Set Date'),
                subtitle: Text(
                  '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                ),
                onTap: () => _selectDate(context),
              ),
            ],
          ),
      ],
    );
  }
}
