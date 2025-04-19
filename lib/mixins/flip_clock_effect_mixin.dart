import 'dart:async';

import 'package:flip_clock_effect_flutter/screens/flip_clock_effect_screen.dart';
import 'package:flutter/material.dart';

mixin FlipClockEffectMixin on State<FlipClockEffectScreen> {
  Duration duration = const Duration(seconds: 1);
  late final AnimationController controller;

  late final Timer timer;

  Duration clockDuration = Duration.zero;

  int clockItem(int row) {
    if (row == 1) {
      return clockDuration.inSeconds ~/ 10;
    } else if (row == 0) {
      return clockDuration.inSeconds % 10;
    }

    return 0;
  }
}
