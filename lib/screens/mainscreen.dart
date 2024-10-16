import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stopwatch/screens/styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int second = 0, minute = 0, hours = 0;
  String secondDigit = "00", minuteDigit = "00", hourDigit = "00";
  Timer? timer;
  bool started = false;
  List laps = [];
  //Start Function
  void startFun() {
    setState(() {
      started = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int sec = second + 1;
      int min = minute;
      int hour = hours;
      if (sec > 59) {
        if (min > 59) {
          hour++;
          min = 0;
        } else {
          min++;
          sec = 0;
        }
      }
      setState(() {
        second = sec;
        minute = min;
        hours = hour;
        secondDigit = (second >= 10) ? "$second" : "0$second";
        minuteDigit = (minute >= 10) ? "$minute" : "0$minute";
        hourDigit = (hour >= 10) ? "$hour" : "0$hour";
      });
    });
  }

  //Stop Function
  void stopFun() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //Reset Function
  void resetFun() {
    timer!.cancel();
    setState(() {
      second = 0;
      minute = 0;
      hours = 0;
      secondDigit = "00";
      minuteDigit = "00";
      hourDigit = "00";
      started = false;
    });
  }

  //Adding Lap in List
  void addLap() {
    String lapData = "$hourDigit:$minuteDigit:$secondDigit";
    setState(() {
      laps.add(lapData);
    });
    // print(lapData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgrounColor,
      appBar: AppBar(
        backgroundColor: Styles.appBarColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer,
              size: 22.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Stopwatch',
              style: Styles.heading,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                "$hourDigit:$minuteDigit:$secondDigit",
                style: Styles.timerText,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (!started) ? startFun : stopFun,
                  child: Icon(
                    (!started) ? Icons.play_circle : Icons.pause_circle,
                    size: 40,
                    color: Styles.buttonColor,
                  ),
                ),
                InkWell(
                  onTap: addLap,
                  child: const Icon(
                    Icons.timer,
                    size: 40,
                    color: Styles.buttonColor,
                  ),
                ),
                InkWell(
                  onTap: resetFun,
                  child: const Icon(
                    Icons.restart_alt,
                    size: 40,
                    color: Styles.buttonColor,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Styles.appBarColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 25.0, bottom: 10.0),
                          child: Text(
                            "Lap : ${laps[index]}",
                            style: Styles.lapStyle,
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
