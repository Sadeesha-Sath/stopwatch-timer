import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/picker_value_enum.dart';
import 'package:stopwatch_timer/src/models/timer_model.dart';
import 'package:stopwatch_timer/src/services/database.dart';
import 'package:stopwatch_timer/src/ui/screens/active_timer_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';
import 'package:stopwatch_timer/src/ui/widgets/set_timer_wheel.dart';

class SetTimerScreen extends StatefulWidget {
  const SetTimerScreen({Key? key, required this.timerModel, this.index}) : super(key: key);
  final TimerModel timerModel;
  final int? index;

  @override
  _SetTimerScreenState createState() => _SetTimerScreenState();
}

class _SetTimerScreenState extends State<SetTimerScreen> {
  late TextEditingController _nameController;
  late FocusNode _focusNode;
  late ValueNotifier<Duration> _duration;
  @override
  void initState() {
    _focusNode = FocusNode();
    _nameController = TextEditingController(text: widget.timerModel.name);
    _duration = ValueNotifier(Duration(seconds: widget.timerModel.durationInSeconds));

    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _nameController.dispose();
    _duration.dispose();
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
                          Database.deleteTimer(widget.index!);
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
                    // floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(22)),
                child: SetTimerWheel(
                  initialValue: widget.timerModel.durationInSeconds,
                  callback: (int value, PickerValue mode) {
                    var seconds = _duration.value.inSeconds % 60;
                    var minutes = _duration.value.inMinutes % 60;
                    var hours = _duration.value.inHours;
                    if (mode == PickerValue.hours) {
                      hours = value;
                    } else if (mode == PickerValue.minutes) {
                      minutes = value;
                    } else {
                      seconds = value;
                    }
                    _duration.value = Duration(hours: hours, minutes: minutes, seconds: seconds);
                  },
                ),
              ),
              SizedBox(height: 70),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                        onPressed: () {
                          Database.putTimers(
                            TimerModel(
                              durationInSeconds: _duration.value.inSeconds,
                              name: _nameController.text,
                            ),
                            index: widget.index,
                          );
                          Navigator.maybePop(context);
                        },
                        child: Text("Save"),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(color: kAccentColor, width: 0.8)),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32, vertical: 31)),
                        )),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      style: ButtonStyle(side: MaterialStateProperty.all(BorderSide(color: kAccentColor, width: 0.8))),
                      onPressed: () {
                        TimerModel _newModel = TimerModel(
                          durationInSeconds: _duration.value.inSeconds,
                          name: _nameController.text,
                        );
                        Database.putTimers(
                          _newModel,
                          index: widget.index,
                        );
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => ActiveTimerScreen(timerModel: _newModel)));
                      },
                      child: Text(
                        "Save and Start",
                        strutStyle: StrutStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                        maxLines: null,
                      ),
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
