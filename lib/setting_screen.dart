import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  static const String routeName = '/setting_screen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController _textFieldInit = TextEditingController();
  TextEditingController _dateTimeFiedInit = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textFieldInit = new TextEditingController(text: '0');
    _dateTimeFiedInit = new TextEditingController(text: '00:00:00');
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.Hms();
    final initTime = DateTime.now();
    //  DateFormat('hh:mm:ss');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(FontAwesomeIcons.arrowLeft),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _textFieldInit,
                decoration: new InputDecoration(
                  labelText: 'Blind Level',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: DateTimeField(
                controller: _dateTimeFiedInit,
                strutStyle: StrutStyle(
                  height: 2,
                ),
                decoration: InputDecoration(
                  label: Text(
                    'Player Time',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                format: format,
                onShowPicker: ((context, currentValue) async {
                  final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()));
                  var playerTime = DateTimeField.convert(time);
                  return playerTime;
                }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: DateTimeField(
                controller: _dateTimeFiedInit,
                strutStyle: StrutStyle(
                  height: 2,
                ),
                decoration: InputDecoration(
                  label: Text(
                    'Blind Time',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                format: format,
                onShowPicker: ((context, currentValue) async {
                  final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                        currentValue ?? initTime,
                      ));
                  var blindTime = DateTimeField.convert(time);
                  return blindTime;
                }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
