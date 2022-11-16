import 'dart:async';
import 'package:countdown_pocker_time/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountDownPokerTime(),
    );
  }
}

class CountDownPokerTime extends StatefulWidget {
  const CountDownPokerTime({super.key, this.title});
  final String? title;

  @override
  State<CountDownPokerTime> createState() => _CountDownPockerTime();
}

class _CountDownPockerTime extends State<CountDownPokerTime> {
  Timer? playerTimer;
  Timer? blindTimer;

  SettingTime? settingState;

  Duration? playerTimeDuration;
  Duration? blindTimeDuration;
  int? currentBlindLevel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poker Countdown App'),
      ),
      body: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: startTimer,
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                          new SettingScreen(setting: settingState),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      settingState = result;
                    });
                  }
                },
                icon: Icon(
                  FontAwesomeIcons.gear,
                ),
                iconSize: 35,
                tooltip: 'Setting',
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3)),
            child: Column(
              children: [
                Text(
                  'Blind Level',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${currentBlindLevel ?? 0}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            formatMMss(playerTimeDuration),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amber,
              fontSize: 50,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: resetTimer,
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: stopTimer,
                child: Text(
                  'Stop',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3)),
            child: Column(
              children: [
                Text(
                  'Blind Timing',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatMMss(blindTimeDuration),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  void startTimer() {
    if (settingState == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('please set the value!')));
    }
    setState(() {
      currentBlindLevel = settingState!.blindLevel;
      playerTimeDuration = Duration(seconds: settingState!.playerTime ?? 0);
      blindTimeDuration = Duration(seconds: settingState!.blindTime ?? 0);
    });
    playerTimer = Timer.periodic(Duration(seconds: 1), (_) => setPlayerTimer());
    blindTimer = Timer.periodic(Duration(seconds: 1), (_) => setBlindTimer());
  }

  void stopTimer() {
    setState(() => playerTimer!.cancel());
    setState(() => blindTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      playerTimeDuration = Duration(seconds: settingState!.playerTime ?? 0);
    });
  }

  // update the countdown and rebuild the page.
  setPlayerTimer() {
    setState(() {
      if (playerTimeDuration?.inSeconds != 0) {
        playerTimeDuration =
            Duration(seconds: playerTimeDuration!.inSeconds - 1);
      } else {
        playerTimer!.cancel();
        playerTimeDuration = Duration(seconds: settingState!.playerTime ?? 0);
      }
    });
  }

  String formatMMss(Duration? duration) {
    final minutes =
        duration?.inMinutes.remainder(60).toString().padLeft(2, '0') ?? '00';
    final seconds =
        duration?.inSeconds.remainder(60).toString().padLeft(2, '0') ?? '00';
    return minutes + ':' + seconds;
  }

  setBlindTimer() {
    setState(() {
      if (blindTimeDuration?.inSeconds != 0) {
        blindTimeDuration = Duration(seconds: blindTimeDuration!.inSeconds - 1);
      } else {
        blindTimeDuration = Duration(seconds: settingState!.blindTime ?? 0);
      }
    });
  }
}
