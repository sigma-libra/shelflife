import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:hive/hive.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/constants.dart';
import 'package:shelflife/utils.dart';

class SettingsPage extends StatefulWidget {
  final Box settingsBox;

  const SettingsPage({super.key, required this.settingsBox});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TimeOfDay selectedTime;
  late String selectedCurrency;

  @override
  void initState() {
    selectedTime =
        Utils.stringToTimeOfDay(widget.settingsBox.get(HIVE_NOTIFICATION_TIME_KEY, defaultValue: Utils.timeOfDayToString(DEFAULT_NOTIFICATION_TIME)));
    selectedCurrency = widget.settingsBox.get(HIVE_CURRENCY_KEY, defaultValue: DEFAULT_CURRENCY);
    super.initState();
  }

  // Function to handle time picker
  Future<void> _selectTime(BuildContext context) async {
    String initialTimeString = widget.settingsBox.get(HIVE_NOTIFICATION_TIME_KEY, defaultValue: Utils.timeOfDayToString(DEFAULT_NOTIFICATION_TIME));
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: Utils.stringToTimeOfDay(initialTimeString),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      // Save the selected time to Hive box
      widget.settingsBox.put(HIVE_NOTIFICATION_TIME_KEY, Utils.timeOfDayToString(picked));
    }
  }

  // Function to handle currency selection
  void _selectCurrency(String currency) {
    setState(() {
      selectedCurrency = currency;
    });
    // Save the selected currency to Hive box
    widget.settingsBox.put(HIVE_CURRENCY_KEY, currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: JAR_BLUE,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: const Text('Notification Time'),
              trailing: Text(
                '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
              ),
              onTap: () => _selectTime(context),
            ),
            const Divider(),
            ListTile(
              title: const Text('Currency'),
              trailing: ElevatedButton(
                onPressed: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showSearchField: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    favorite: ['eur'],
                    onSelect: (Currency currency) {
                      _selectCurrency(currency.symbol);
                    },
                  );
                },
                child: Text(selectedCurrency),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
