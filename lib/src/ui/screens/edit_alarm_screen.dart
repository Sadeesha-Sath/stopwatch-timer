import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/alarm_model.dart';
import 'package:stopwatch_timer/src/services/database.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class EditAlarmScreen extends StatefulWidget {
  const EditAlarmScreen({Key? key, required this.alarmModel, this.index}) : super(key: key);
  final AlarmModel alarmModel;
  final int? index;

  @override
  _EditAlarmScreenState createState() => _EditAlarmScreenState();
}

class _EditAlarmScreenState extends State<EditAlarmScreen> {
  late final TextEditingController _nameController;
  late FocusNode _focusNode;
  late ValueNotifier<bool> _isVibrate;
  late Set<int> _activeDays;
  late TimeOfDay _alarmTime;

  @override
  void initState() {
    _focusNode = FocusNode();
    _alarmTime = widget.alarmModel.alarmTime;
    _activeDays = widget.alarmModel.activeDays.toSet();
    _isVibrate = ValueNotifier<bool>(widget.alarmModel.isVibrate);
    _nameController = TextEditingController(text: widget.alarmModel.name);
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _isVibrate.dispose();
    _focusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_turn_up_left,
                      ),
                    ),
                    Visibility(
                      visible: widget.index != null,
                      child: IconButton(
                        onPressed: () {
                          Database.deleteAlarm(widget.index!);
                          Navigator.maybePop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.trash,
                          color: Colors.redAccent.shade100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: TextField(
                  focusNode: _focusNode,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    filled: true,
                    fillColor: kCardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: _focusNode.hasFocus ? kAccentColor : null,
                    ),
                  ),
                  controller: _nameController,
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: kCardColor),
                // height: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mon, Tue, Sat",
                          style: TextStyle(color: kTextColor),
                        ),
                        Icon(
                          CupertinoIcons.calendar,
                          color: kTextColor,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: List.generate(
                          7,
                          (index) => WeekDay(
                            index: index,
                            activeDays: _activeDays,
                            onTap: () {
                              if (_activeDays.contains(index)) {
                                setState(() {
                                  _activeDays.remove(index);
                                });
                              } else {
                                setState(() {
                                  _activeDays.add(index);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      width: double.maxFinite,
                      child: InkWell(
                        onTap: () async {
                          var pickedTime = await showTimePicker(
                            context: context,
                            initialTime: _alarmTime,
                          );
                          if (pickedTime != null)
                            setState(() {
                              _alarmTime = pickedTime;
                            });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Alarm Time",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(_alarmTime.format(context), style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Alarm Tone",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Alarm",
                                style: TextStyle(fontSize: 14, color: kAccentColor),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: double.maxFinite,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _isVibrate.value = !_isVibrate.value;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Vibrate",
                              style: TextStyle(fontSize: 18),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _isVibrate,
                              builder: (context, value, __) => Switch(
                                value: value,
                                onChanged: (bool newValue) {
                                  _isVibrate.value = newValue;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                        },
                        child: Text("Cancel", strutStyle: StrutStyle(fontSize: 22)),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(color: kUnselectedColor)),
                          // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32, vertical: 31)),
                        )),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      style: ButtonStyle(side: MaterialStateProperty.all(BorderSide(color: kAccentColor))),
                      onPressed: () {
                        Database.putAlarms(
                          AlarmModel(
                            alarmTime: _alarmTime,
                            name: _nameController.text,
                            isActive: widget.alarmModel.isActive,
                            activeDays: _activeDays.toList(),
                            isVibrate: _isVibrate.value,
                          ),
                          index: widget.index,
                        );
                        Navigator.maybePop(context);
                      },
                      child: Text("Save", strutStyle: StrutStyle(fontSize: 22)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class WeekDay extends StatelessWidget {
  const WeekDay({
    Key? key,
    required this.index,
    required this.activeDays,
    required this.onTap,
  }) : super(key: key);
  final int index;
  final VoidCallback onTap;
  final Set<int> activeDays;
  static const List<String> _daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    bool isActive = activeDays.contains(index);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: isActive ? BoxDecoration(border: Border.all(color: kAccentColor), shape: BoxShape.circle) : null,
        padding: isActive ? EdgeInsets.all(3) : null,
        child: Text(_daysOfWeek.elementAt(index)),
      ),
    );
  }
}
