import 'package:flutter/material.dart';

class SettingTime {
  int? blindTime;
  int? playerTime;
  int? blindLevel;

  SettingTime({this.blindLevel, this.blindTime, this.playerTime});
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key, this.setting});
  final SettingTime? setting;

  static const String routeName = '/setting_screen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController _blindLevelControler = TextEditingController();
  TextEditingController _playerTimeControler = TextEditingController();
  TextEditingController _blindTimeController = TextEditingController();

  late SettingTime settingState;

  @override
  void initState() {
    super.initState();
    settingState = widget.setting ??
        SettingTime(blindLevel: 1, playerTime: 60, blindTime: 2 * 60);
    _blindLevelControler =
        TextEditingController(text: settingState.blindLevel.toString());
    _playerTimeControler =
        TextEditingController(text: settingState.playerTime.toString());
    _blindTimeController =
        TextEditingController(text: settingState.blindTime.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          textAlign: TextAlign.center,
        ),
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
                controller: _blindLevelControler,
                decoration: new InputDecoration(
                  labelText: 'Blind Level',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  settingState.blindLevel = int.tryParse(text);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _blindTimeController,
                decoration: new InputDecoration(
                  labelText: 'Blind Timer',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  settingState.blindTime = int.tryParse(text);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _playerTimeControler,
                decoration: new InputDecoration(
                  labelText: 'Player Timer',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  settingState.playerTime = int.tryParse(text);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(settingState);
              },
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
