import 'package:flutter/material.dart';
import 'package:stopwatch_timer/src/ui/screens/alarm_screen.dart';
import 'package:stopwatch_timer/src/ui/screens/stopwatch_screen.dart';
import 'package:stopwatch_timer/src/ui/screens/timer_screen.dart';
import 'package:stopwatch_timer/src/ui/ui_constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  final List<Widget> _screens = [AlarmScreen(), StopwatchScreen(), TimerScreen()];
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   selectedFontSize: 14,
        //   unselectedFontSize: 14,
        //   onTap: (index) {
        //     setState(() {
        //       _pageController.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
        //     });
        //   },
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarms"),
        //     BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Stopwatch"),
        //     BottomNavigationBarItem(icon: Icon(Icons.watch_later_outlined), label: "Timer"),
        //   ],
        // ),
        bottomNavigationBar: BottomAppBar(
          elevation: 1,
          color: kBackgroundColor,
          child: SizedBox(
            width: width,
            height: kBottomNavigationBarHeight - 5,
            child: Row(
              children: List.unmodifiable(
                Iterable.generate(3, _buildCustomBottomNavBarItem),
              ),
            ),
          ),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: widget._screens,
          ),
        ),
      ),
    );
  }

  Expanded _buildCustomBottomNavBarItem(int index) {
    var _text = ["Alarms", "Stopwatch", "Timer"];
    assert(index < 3, "The parameter index is out of Range. Valid range is 0-2 and got $index");
    bool _isSelected = index == _currentIndex;
    return Expanded(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: _isSelected ? kCardColor : kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: index != 0 ? Radius.circular(20) : Radius.zero,
            topRight: index != 2 ? Radius.circular(20) : Radius.zero,
          ),
        ),
        duration: Duration(milliseconds: 200),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              // _currentIndex = index;
              _pageController.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
            });
          },
          child: Center(
            child: Text(
              _text[index],
              style: TextStyle(
                fontSize: 17,
                color: _isSelected ? kAccentColor : kUnselectedColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
