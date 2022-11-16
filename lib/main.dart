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
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: const CountDownPokerTime(
        title: 'Poker Countdown App',
      ),
    );
  }
}

class CountDownPokerTime extends StatefulWidget {
  const CountDownPokerTime({super.key, required this.title});
  final String title;
  @override
  State<CountDownPokerTime> createState() => _CountDownPockerTime();
}

class _CountDownPockerTime extends State<CountDownPokerTime> {
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);
  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  // update the countdown and rebuild the page.
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    // final days = strDigits(myDuration.inDays);
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final int blindLevel = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
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
                // onPressed: () {
                //   Navigator.of(context).pushNamed(SettingScreen.routeName);
                // },
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new SettingScreen(),
                    ),
                  );
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
                  '$blindLevel',
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
            '$hours:$minutes:$seconds',
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
                  '$hours:$minutes:$seconds',
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
}
