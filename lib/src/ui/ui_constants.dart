import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFF1A1F39);
const Color kPrimaryColor = Color(0xFFF3C103);
const Color kAccentColor = Color(0xFFF9E30B);
const Color kUnselectedColor = Color(0xFF828488);
const Color kCardColor = Color(0xFF2D314F);
const Color kCardSectionGoldColor = Color(0xFFE4C032);
const Color kTextColor = Color(0xFFE3E3E3);

Set<MaterialState> _activeStates = {
  MaterialState.pressed,
  MaterialState.selected,
  MaterialState.hovered,
  MaterialState.dragged,
  MaterialState.focused,
};

class ThumbColor extends MaterialStateColor {
  const ThumbColor() : super(_defaultColor);

  static const int _defaultColor = 0xFFAAAAAA;
  static const int _pressedColor = 0xFFFAE400;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.any(_activeStates.contains)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

class TrackColor extends MaterialStateColor {
  const TrackColor() : super(_defaultColor);

  static const int _defaultColor = 0xFF777777;
  static const int _pressedColor = 0xFFE1CA72;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.any(_activeStates.contains)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

class OutlineBorderSide extends MaterialStateBorderSide {
  static const BorderSide _defaultBorderSide = BorderSide(color: Color(0xFF393C5E));
  static const BorderSide _activeBorderSide = BorderSide(color: kAccentColor);

  @override
  BorderSide? resolve(Set<MaterialState> states) {
    if (states.any(_activeStates.contains)) {
      return _activeBorderSide;
    }
    return _defaultBorderSide;
  }
}
