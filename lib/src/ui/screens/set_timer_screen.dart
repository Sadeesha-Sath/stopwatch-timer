import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/models/timer_model.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class SetTimerScreen extends StatefulWidget {
  const SetTimerScreen({Key? key, required this.timerModel}) : super(key: key);
  final TimerModel timerModel;

  @override
  _SetTimerScreenState createState() => _SetTimerScreenState();
}

class _SetTimerScreenState extends State<SetTimerScreen> {
  late var _nameController;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _nameController = TextEditingController(text: widget.timerModel.name);

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.arrow_turn_up_left,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                // padding: EdgeInsets.only(left: 30),
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: kCardColor),
                child: TextField(
                  focusNode: _focusNode,
                  style: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      // border: InputBorder.none,
                      filled: true,
                      fillColor: kCardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                      labelText: "Name",
                      // floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(fontSize: 18, color: _focusNode.hasFocus ? kAccentColor : null)),
                  controller: _nameController,
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Container(
                decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(22)),
                // TODO Add a custom widget
                child: CupertinoTimerPicker(
                  initialTimerDuration: widget.timerModel.duration,
                  onTimerDurationChanged: (Duration duration) {},
                ),
              ),
              SizedBox(height: 120),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                        onPressed: () {},
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
                        style:
                            ButtonStyle(side: MaterialStateProperty.all(BorderSide(color: kAccentColor, width: 0.8))),
                        onPressed: () {},
                        child: Text(
                          "Save and Start",
                          strutStyle: StrutStyle(fontSize: 22),
                          textAlign: TextAlign.center,
                          maxLines: null,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
