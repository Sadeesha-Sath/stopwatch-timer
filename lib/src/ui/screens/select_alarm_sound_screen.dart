import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/android_sounds.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/custom_back_button.dart';

class SelectAlarmSoundScreen extends StatefulWidget {
  const SelectAlarmSoundScreen({Key? key}) : super(key: key);

  static const androidSounds = ["Alarm", "Notification", "Ringtone"];

  @override
  _SelectAlarmSoundScreenState createState() => _SelectAlarmSoundScreenState();
}

class _SelectAlarmSoundScreenState extends State<SelectAlarmSoundScreen> {
  bool _isAndroid = Platform.isAndroid;
  int groupVal = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Alarm Tone",
          style: TextStyle(color: kTextColor),
        ),
        centerTitle: true,
        leading: CustomBackButton(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check,
              color: kAccentColor,
            ),
          ),
        ],
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 7.5),
          itemCount: _isAndroid ? 3 : 15,
          itemBuilder: (context, index) => RadioListTile<int>(
                activeColor: kAccentColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                groupValue: groupVal,
                onChanged: (int? value) {
                  setState(() {
                    groupVal = value!;
                  });
                },
                value: index,
                title: Text(
                  SelectAlarmSoundScreen.androidSounds[index],
                  style: TextStyle(color: kTextColor),
                ),
                secondary: IconButton(
                  icon: Icon(Icons.headphones, color: kTextColor),
                  onPressed: () {
                    FlutterRingtonePlayer.play(
                        android: AndroidSound(index + 1), ios: IosSound(int.parse("100${index + 1}")), looping: false);
                  },
                ),
              )),
    );
  }
}
